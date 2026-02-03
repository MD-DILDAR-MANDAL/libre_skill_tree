abstract class SkillTreeEvent {}

class CreateNewTree extends SkillTreeEvent {}

class LoadInitialTreeData extends SkillTreeEvent {}

class RealignTree extends SkillTreeEvent {}

class ExportTreeJson extends SkillTreeEvent {}

class DeleteNode extends SkillTreeEvent {
  DeleteNode(this.nodeId);
  String nodeId;
}
