import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class SkillTreeScreen extends StatefulWidget {
  const SkillTreeScreen({super.key});

  @override
  State<SkillTreeScreen> createState() => _SkillTreeScreenState();
}

class _SkillTreeScreenState extends State<SkillTreeScreen> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox.expand(
        child: SceneBuilderWidget(
          builder: () => SceneController(front: SkillTreeScene()),
        ),
      ),
    );
  }
}

class SkillData {
  final String id;
  final String name;
  final double x;
  final double y;

  SkillData(this.id, this.name, this.x, this.y);
}

class SkillTreeScene extends GSprite {
  late GSprite nodesLayer;
  late GSprite edgesLayer;

  final skills = <SkillData>[
    SkillData("1", "Root", 200, 200),
    SkillData("2", "Skill A", 400, 350),
    SkillData("3", "Skill B", 0, 350),
  ];

  @override
  void addedToStage() {
    nodesLayer = addChild(GSprite());
    edgesLayer = addChild(GSprite());

    buildNodes();
    buildEdges();
  }

  void buildNodes() {
    for (var skill in skills) {
      final node = nodesLayer.addChild(SkillNode(skill.name));
      node.x = skill.x;
      node.y = skill.y;
      node.name = skill.id;
    }
  }

  void buildEdges() {
    final root = nodesLayer.getChildByName("1") as SkillNode;
    final skillA = nodesLayer.getChildByName("2") as SkillNode;
    final skillB = nodesLayer.getChildByName("3") as SkillNode;

    drawLine(root, skillA);
    drawLine(root, skillB);
  }

  void drawLine(GDisplayObject a, GDisplayObject b) {
    final edge = edgesLayer.addChild(GShape());
    edge.graphics
        .lineStyle(4, Colors.white)
        .moveTo(a.x, a.y)
        .lineTo(b.x, b.y)
        .endFill();
  }
}

class SkillNode extends GSprite {
  final String label;
  late GShape bg;

  SkillNode(this.label);

  @override
  void addedToStage() {
    // Background circle
    bg = addChild(GShape());
    bg.graphics.beginFill(Colors.deepPurple).drawCircle(0, 0, 35).endFill();

    final textContainer = addChild(GSprite());
    final text = textContainer.addChild(GText(text: label));
    text.alignPivot();
    textContainer.y = 55;

    mouseEnabled = true;
    onMouseOver.add((_) => bg.alpha = 0.7);
    onMouseOut.add((_) => bg.alpha = 1.0);

    _pulse();
  }

  void _pulse() {
    bg.tween(
      duration: 1,
      scaleX: 1.15,
      scaleY: 1.15,
      ease: GEase.easeInOut,
      onComplete: () {
        bg.tween(
          duration: 1,
          scaleX: 1,
          scaleY: 1,
          ease: GEase.easeInOut,
          onComplete: _pulse,
        );
      },
    );
  }
}
