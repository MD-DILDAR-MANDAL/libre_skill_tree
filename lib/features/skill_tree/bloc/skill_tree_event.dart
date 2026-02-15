import 'package:libre_skill_tree/features/skill_tree/screens/skill_tree_screen.dart';

class AddConnectedNode extends SkillTreeEvent {
  String parentId;
  AddConnectedNode(this.parentId);
}

class CreateNewTree extends SkillTreeEvent {}

class DeleteNode extends SkillTreeEvent {
  String nodeId;
  DeleteNode(this.nodeId);
}

class EditLevel extends SkillTreeEvent {
  String nodeId;
  Level level;
  EditLevel(this.nodeId, this.level);
}

class RenameNode extends SkillTreeEvent {
  final String nodeId;
  final String newTitle;
  RenameNode(this.nodeId, this.newTitle);
}

class ExportTreeJson extends SkillTreeEvent {}

class LoadInitialTreeData extends SkillTreeEvent {}

class RealignTree extends SkillTreeEvent {}

abstract class SkillTreeEvent {}
