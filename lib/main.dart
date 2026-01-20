import 'package:flutter/material.dart';
import 'package:libre_skill_tree/features/skill_tree/repository/skill_tree_repository.dart';
import 'package:libre_skill_tree/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = SkillTreeRepository();
  await repository.init();
  runApp(MyApp(repository: repository));
}
