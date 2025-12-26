import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';
import 'package:libre_skill_tree/features/skill_tree/graphx/skill_tree_scene.dart';

class SkillTreeScreen extends StatefulWidget {
  const SkillTreeScreen({super.key});

  @override
  State<SkillTreeScreen> createState() => _SkillTreeScreenState();
}

class _SkillTreeScreenState extends State<SkillTreeScreen> {
  final List<SkillTreeModel> localTrees = [];
  void addTree() {
    setState(() {
      localTrees.add(
        SkillTreeModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: "My Skill Tree",
          nodes: [
            SkillNodeModel(
              id: "1",
              title: "Root",
              x: 200,
              y: 200,
              locked: false,
            ),
            SkillNodeModel(id: "2", title: "Skill A", x: 400, y: 350),
            SkillNodeModel(id: "3", title: "Skill B", x: 0, y: 350),
          ],
          edges: [
            SkillEdgeModel(fromNodeId: "1", toNodeId: "2"),
            SkillEdgeModel(fromNodeId: "1", toNodeId: "3"),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FilledButton(
              onPressed: () {
                addTree();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline),
                  Text(" Add Skill Tree"),
                ],
              ),
            ),
            Scrollbar(
              thumbVisibility: true,
              thickness: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: 800,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(38.0, 0.0, 0.0, 0.0),
                      child: localTrees.isNotEmpty
                          ? SceneBuilderWidget(
                              builder: () => SceneController(
                                front: SkillTreeScene(localTrees.first),
                              ),
                            )
                          : Text("add tree"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
