import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_event.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_state.dart';
import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';
import 'package:libre_skill_tree/features/skill_tree/repository/skill_tree_repository.dart';

class SkillTreeBloc extends Bloc<SkillTreeEvent, SkillTreeState> {
  final SkillTreeRepository repository;

  SkillTreeBloc(this.repository) : super(SkillTreeState()) {
    on<CreateNewTree>(onCreateNewTree);
    on<LoadInitialTreeData>(onLoadInitialTreeData);
    on<DeleteNode>(onDeleteNode);
    on<RealignTree>(_onRealignTree);
  }

  Future<void> onCreateNewTree(
    CreateNewTree event,
    Emitter<SkillTreeState> emit,
  ) async {
    final newTree = SkillTreeModel(
      name: "SkillTree1",
      nodes: [
        SkillNodeModel(
          id: "root",
          title: "New Goal",
          x: 0,
          y: 0,
          level: 0,
          locked: false,
        ),
      ],
      edges: [],
    );
    await repository.saveTree(newTree);
    emit(SkillTreeState(activeTree: newTree));
    if (kDebugMode) {
      debugPrint("created new tree");
    }
  }

  Future<void> onLoadInitialTreeData(
    LoadInitialTreeData event,
    Emitter<SkillTreeState> emit,
  ) async {
    List<SkillTreeModel> trees = await repository.getAllTrees();
    emit(SkillTreeState(activeTree: trees.first));
    if (kDebugMode) {
      debugPrint("loaded initial data");
    }
  }

  Future<void> _onRealignTree(
    RealignTree event,
    Emitter<SkillTreeState> emit,
  ) async {
    debugPrint("calling realignTree");
    SkillTreeModel? tmpActiveTree = state.activeTree;
    if (tmpActiveTree == null || tmpActiveTree!.nodes.isEmpty) return;

    double getSubtreeWidth(String parentId) {
      //extracting all the edges having parentId root
      final children = tmpActiveTree!.edges
          .where((e) => e.fromNodeId == parentId)
          .toList();
      // Base width for a single node
      if (children.isEmpty) return 120.0;

      double totalWidth = 0;
      for (var edge in children) {
        totalWidth += getSubtreeWidth(edge.toNodeId);
      }
      return totalWidth;
    }

    void positionNodes(String nodeId, double leftBoundary, double y) {
      final node = tmpActiveTree!.nodes.firstWhere((n) => n.id == nodeId);
      final childrenEdges = tmpActiveTree!.edges
          .where((e) => e.fromNodeId == nodeId)
          .toList();

      double subtreeWidth = getSubtreeWidth(nodeId);
      node.x = leftBoundary + (subtreeWidth / 2);
      node.y = y;

      double currentLeft = leftBoundary;
      for (var edge in childrenEdges) {
        double childWidth = getSubtreeWidth(edge.toNodeId);
        positionNodes(edge.toNodeId, currentLeft, y + 150);
        currentLeft += childWidth;
      }
    }

    // 3. Execute realignment
    // We treat the root as the center of its own universe
    double rootWidth = getSubtreeWidth("root");
    positionNodes("root", -(rootWidth / 2), 0);

    // 4. Save the calculated positions back to Isar
    await repository.saveTree(tmpActiveTree!);
    final updatedTrees = await repository.getAllTrees();
    SkillTreeModel newTree = updatedTrees.firstWhere(
      (t) => t.id == tmpActiveTree?.id,
    );
    emit(SkillTreeState(activeTree: newTree));
  }

  Future<void> onDeleteNode(
    DeleteNode event,
    Emitter<SkillTreeState> emit,
  ) async {
    String nodeId = event.nodeId;

    // if (nodeId == "root") {
    //   widget.repository.deleteTree(activeTree!.name);
    //   setState(() => activeTree = null);
    //   return;
    // }
    SkillTreeModel? tmpActiveTree = state.activeTree;

    Future<void> deleteNode(String nodeId) async {
      if (nodeId == "") return;

      final List<String> deletedNodes = [nodeId];

      for (var edge in tmpActiveTree!.edges) {
        if (edge.fromNodeId == nodeId && edge.toNodeId != '') {
          deletedNodes.add(edge.toNodeId);
          deleteNode(edge.toNodeId);
        }
      }

      tmpActiveTree!.nodes = tmpActiveTree!.nodes
          .where((n) => deletedNodes.contains(n.id) != true)
          .toList();

      tmpActiveTree!.edges = tmpActiveTree!.edges
          .where((e) => e.fromNodeId != nodeId && e.toNodeId != nodeId)
          .toList();

      await repository.saveTree(tmpActiveTree!);
    }

    await deleteNode(nodeId);
    emit(SkillTreeState(activeTree: tmpActiveTree));
    add(RealignTree());
  }
}
