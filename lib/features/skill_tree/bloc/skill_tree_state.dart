import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';

enum SkillTreeStateStatus { initial, loading, loaded, error }

class SkillTreeState {
  SkillTreeState({
    this.activeTree,
    this.status = SkillTreeStateStatus.initial,
    this.exception,
  });

  final SkillTreeModel? activeTree;
  final SkillTreeStateStatus status;
  final Exception? exception;
}
