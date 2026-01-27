import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';
import 'package:path_provider/path_provider.dart';

class SkillTreeRepository {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([SkillTreeModelSchema], directory: dir.path);
  }

  Future<List<SkillTreeModel>> getAllTrees() =>
      isar.skillTreeModels.where().findAll();

  Future<void> saveTree(SkillTreeModel tree) async {
    await isar.writeTxn(() => isar.skillTreeModels.put(tree));
  }

  Future<void> deleteTree(String treeName) async {
    await isar.writeTxn(() async {
      await isar.skillTreeModels.filter().nameEqualTo(treeName).deleteAll();
    });

    if (kDebugMode) {
      debugPrint("deleted tree $treeName");
    }
  }
}
