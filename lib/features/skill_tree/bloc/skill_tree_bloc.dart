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
}
