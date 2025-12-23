class SkillModel {
  final String id;
  final String name;
  final String parentId;
  final int level;
  final bool isLocked;

  SkillModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.level,
    required this.isLocked,
  });
}
