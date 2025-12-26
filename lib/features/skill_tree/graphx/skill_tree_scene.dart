import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';

class SkillTreeScene extends GSprite {
  final SkillTreeModel tree;
  SkillTreeScene(this.tree);

  late GSprite nodesLayer;
  late GSprite edgesLayer;

  @override
  void addedToStage() {
    nodesLayer = addChild(GSprite());
    edgesLayer = addChild(GSprite());

    buildNodes();
    buildEdges();
  }

  void buildNodes() {
    for (var skill in tree.nodes) {
      final node = nodesLayer.addChild(SkillNode(skill.title));
      node.x = skill.x;
      node.y = skill.y;
      node.name = skill.id;
    }
  }

  void buildEdges() {
    for (var edge in tree.edges) {
      final from = nodesLayer.getChildByName(edge.fromNodeId) as GDisplayObject;
      final to = nodesLayer.getChildByName(edge.toNodeId) as GDisplayObject;
      drawLine(from, to);
    }
  }

  void drawLine(GDisplayObject a, GDisplayObject b) {
    final edge = edgesLayer.addChild(GShape());
    edge.graphics
        .lineStyle(4, Colors.redAccent)
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
