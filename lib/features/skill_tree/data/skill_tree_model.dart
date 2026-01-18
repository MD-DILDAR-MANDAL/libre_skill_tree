import 'package:isar_community/isar.dart';

part 'skill_tree_model.g.dart';

@Collection()
class SkillTreeModel {
  Id id = Isar.autoIncrement;

  late String name;
  late List<SkillNodeModel> nodes;
  late List<SkillEdgeModel> edges;

  SkillTreeModel({
    required this.name,
    required this.nodes,
    required this.edges,
  });

  // For JSON Export
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nodes': nodes.map((e) => e.toJson()).toList(),
    'edges': edges.map((e) => e.toJson()).toList(),
  };
}

@embedded
class SkillNodeModel {
  late String id;
  late String title;
  late double x;
  late double y;
  late int level;
  late int maxLevel;
  late bool locked;

  SkillNodeModel({
    this.id = '',
    this.title = '',
    this.x = 0,
    this.y = 0,
    this.level = 0,
    this.maxLevel = 5,
    this.locked = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'x': x,
    'y': y,
    'level': level,
    'locked': locked,
  };
}

@embedded
class SkillEdgeModel {
  late String fromNodeId;
  late String toNodeId;

  SkillEdgeModel({this.fromNodeId = '', this.toNodeId = ''});

  Map<String, dynamic> toJson() => {
    'fromNodeId': fromNodeId,
    'toNodeId': toNodeId,
  };
}
