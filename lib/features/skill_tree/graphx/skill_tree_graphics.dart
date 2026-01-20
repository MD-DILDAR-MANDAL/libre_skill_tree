import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';

typedef OnSkillNodeTap = void Function(String nodeId);

class SkillTreeScene extends GSprite {
  final SkillTreeModel tree;
  final OnSkillNodeTap onNodeTap;

  SkillTreeScene(this.tree, {required this.onNodeTap});

  late GSprite camera;
  late GSprite nodesLayer;
  late GSprite edgesLayer;

  @override
  void addedToStage() {
    camera = addChild(GSprite());
    // Note: To ensure lines are UNDER nodes, add edgesLayer first
    edgesLayer = camera.addChild(GSprite());
    nodesLayer = camera.addChild(GSprite());

    buildNodes();
    buildEdges();
    Future.microtask(_centerRoot);
    _enablePan();
  }

  void buildNodes() {
    for (var skill in tree.nodes) {
      final node = nodesLayer.addChild(
        SkillNode(
          nodeId: skill.id,
          label: skill.title,
          level: skill.level,
          onNodeTap: onNodeTap,
        ),
      );
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
        .lineStyle(3, Colors.deepOrangeAccent)
        .moveTo(a.x, a.y)
        .lineTo(b.x, b.y)
        .endFill();
  }

  void _centerRoot() {
    if (stage == null || stage!.stageWidth <= 0) {
      stage!.onEnterFrame.addOnce((_) => _centerRoot());
      return;
    }

    final rootNode = tree.nodes.firstWhere(
      (n) => n.id == "root",
      orElse: () =>
          tree.nodes.isNotEmpty ? tree.nodes.first : SkillNodeModel(x: 0, y: 0),
    );

    camera.x = stage!.stageWidth / 2 - rootNode.x;
    camera.y = stage!.stageHeight / 2 - rootNode.y;
  }

  void _enablePan() {
    double lastX = 0;
    double lastY = 0;
    bool isDragging = false;

    stage!.onMouseDown.add((e) {
      if (e.target == stage || e.target == camera || e.target == edgesLayer) {
        isDragging = true;
        lastX = e.stageX;
        lastY = e.stageY;
      }
    });

    stage!.onMouseMove.add((e) {
      if (isDragging) {
        final dx = e.stageX - lastX;
        final dy = e.stageY - lastY;
        camera.x += dx;
        camera.y += dy;
        lastX = e.stageX;
        lastY = e.stageY;
      }
    });
    stage!.onMouseUp.add((e) => isDragging = false);
  }
}

class SkillNode extends GSprite {
  final String nodeId;
  final String label;
  final int level;
  final OnSkillNodeTap onNodeTap;
  late GShape bg;

  SkillNode({
    required this.nodeId,
    required this.label,
    required this.level,
    required this.onNodeTap,
  });

  @override
  void addedToStage() {
    Color ringColor;
    if (level == 0) {
      ringColor = Colors.grey;
    } else if (level == 1) {
      ringColor = Colors.blueAccent;
    } else if (level == 2) {
      ringColor = Colors.greenAccent;
    } else {
      ringColor = Colors.purpleAccent;
    }
    // Background circle
    bg = addChild(GShape());
    bg.graphics.beginFill(ringColor).drawCircle(0, 0, 35).endFill();
    bg.graphics.beginFill(Color(0xFF151a7d)).drawCircle(0, -9, 24);
    final text = addChild(
      GText(
        text: label,
        textStyle: const TextStyle(
          backgroundColor: Color(0xFF151a7d),
          fontFamily: 'Oxanium',
          color: Colors.amber,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    text.alignPivot();
    text.y = 50;

    mouseEnabled = true;

    onMouseOver.add((_) => bg.alpha = 0.7);
    onMouseOut.add((_) => bg.alpha = 1.0);

    onMouseDown.add((e) {
      onNodeTap(nodeId);
    });

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
