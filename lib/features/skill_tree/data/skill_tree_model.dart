class SkillTreeModel {
  final String id;
  final String name;
  final List<SkillNodeModel> nodes;
  final List<SkillEdgeModel> edges;

  SkillTreeModel({
    required this.id,
    required this.name,
    required this.nodes,
    required this.edges,
  });
}

class SkillNodeModel {
  final String id;
  final String title;
  final double x;
  final double y;
  final int level;
  final int maxLevel;
  final bool locked;

  SkillNodeModel({
    required this.id,
    required this.title,
    required this.x,
    required this.y,
    this.level = 0,
    this.maxLevel = 5,
    this.locked = true,
  });
}

class SkillEdgeModel {
  final String fromNodeId;
  final String toNodeId;

  SkillEdgeModel({required this.fromNodeId, required this.toNodeId});
}
