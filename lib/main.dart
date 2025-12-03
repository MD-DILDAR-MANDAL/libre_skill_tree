import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: SceneBuilderWidget(
            builder: () => SceneController(front: MyScene()),
          ),
        ),
      ),
    );
  }
}

class MyScene extends GSprite {
  late GShape circle;
  @override
  void addedToStage() {
    circle = addChild(GShape());
    circle.graphics.beginFill(Colors.purple).drawCircle(0, 0, 20).endFill();
    circle.x = 150;
    circle.y = 150;
    circle.onMouseDown.add((event) {
      circle.graphics
        ..clear()
        ..beginFill(Colors.red)
        ..drawCircle(0, 0, 50);
    });
    circle.onMouseOver.add((event) {
      circle.alpha = 0.7;
    });

    circle.onMouseOut.add((event) {
      circle.alpha = 1.0;
    });

    pulseCircle();
  }

  void pulseCircle() {
    circle.tween(
      duration: 1,
      scaleX: 1.2,
      scaleY: 1.2,
      ease: GEase.easeInOut,
      onComplete: () {
        circle.tween(
          duration: 1,
          scaleX: 1,
          scaleY: 1,
          ease: GEase.easeInOut,
          onComplete: pulseCircle,
        );
      },
    );
  }
}
