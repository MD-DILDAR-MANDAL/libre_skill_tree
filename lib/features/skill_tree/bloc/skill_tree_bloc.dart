import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_event.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_state.dart';
import 'package:libre_skill_tree/features/skill_tree/models/skill_tree_model.dart';
import 'package:libre_skill_tree/features/skill_tree/repository/skill_tree_repository.dart';
import 'package:libre_skill_tree/features/skill_tree/screens/skill_tree_screen.dart';

class SkillTreeBloc extends Bloc<SkillTreeEvent, SkillTreeState> {
  final SkillTreeRepository repository;

  SkillTreeBloc(this.repository) : super(SkillTreeState()) {
    on<CreateNewTree>(onCreateNewTree);
    on<LoadInitialTreeData>(onLoadInitialTreeData);
    on<AddConnectedNode>(onAddConnectedNode);
    on<EditLevel>(onEditLevel);
    on<RenameNode>(onRenameNode);
    on<DeleteNode>(onDeleteNode);
    on<RealignTree>(onRealignTree);
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

  Future<void> onAddConnectedNode(
    AddConnectedNode event,
    Emitter<SkillTreeState> emit,
  ) async {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final newNode = SkillNodeModel(
      id: newId,
      title: "New Node",
      x: 0,
      y: 0,
      locked: true,
    );
    SkillTreeModel currentTree = state.activeTree!;
    currentTree.nodes = List<SkillNodeModel>.from(currentTree.nodes)
      ..add(newNode);
    currentTree.edges = List<SkillEdgeModel>.from(currentTree.edges)
      ..add(SkillEdgeModel(fromNodeId: event.parentId, toNodeId: newId));

    await repository.saveTree(currentTree);
    emit(SkillTreeState(activeTree: currentTree));
    add(RealignTree());
  }

  Future<void> onLoadInitialTreeData(
    LoadInitialTreeData event,
    Emitter<SkillTreeState> emit,
  ) async {
    List<SkillTreeModel>? trees = await repository.getAllTrees();
    emit(SkillTreeState(activeTree: trees.isEmpty ? null : trees.first));
    if (kDebugMode) {
      debugPrint("loaded initial data");
    }
  }

  Future<void> onRealignTree(
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

  Future<void> onEditLevel(EditLevel event, Emitter emit) async {
    SkillTreeModel currentTree = state.activeTree!;

    final SkillNodeModel levelNode = currentTree.nodes.firstWhere(
      (n) => n.id == event.nodeId,
    );

    switch (event.level) {
      case Level.rookie:
        levelNode.level = 1;
        break;
      case Level.veteran:
        levelNode.level = 2;
        break;
      case Level.master:
        levelNode.level = 3;
        break;
      default:
        levelNode.level = 0;
    }
    List<SkillNodeModel> updatedNodes = [];
    for (SkillNodeModel node in currentTree.nodes) {
      if (node.id != event.nodeId) {
        updatedNodes.add(node);
      }
    }
    updatedNodes.add(levelNode);
    currentTree.nodes = updatedNodes;

    // Unlock logic (example: if parent is leveled up, children could unlock)
    // For now, we just save the level
    await repository.saveTree(currentTree);
    emit(SkillTreeState(activeTree: currentTree));
  }

  Future<void> onRenameNode(
    RenameNode event,
    Emitter<SkillTreeState> emit,
  ) async {
    final SkillTreeModel currentTree = state.activeTree!;

    final updatedNodes = currentTree.nodes.map((node) {
      if (node.id == event.nodeId) {
        node.title = event.newTitle;
      }
      return node;
    }).toList();

    currentTree.nodes = updatedNodes;

    await repository.saveTree(currentTree);

    emit(
      SkillTreeState(
        activeTree: currentTree,
        status: SkillTreeStateStatus.loaded,
      ),
    );
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

    if (nodeId == "root") {
      repository.deleteTree(tmpActiveTree!.name);
      emit(SkillTreeState(activeTree: null));
      return;
    }

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
