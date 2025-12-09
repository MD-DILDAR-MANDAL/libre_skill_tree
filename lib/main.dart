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
  late GShape rectangle;

  @override
  void addedToStage() {
    circle = addChild(GShape());
    circle.graphics.beginFill(Colors.purple).drawCircle(0, 0, 20).endFill();
    circle.x = 150;
    circle.y = 150;

    rectangle = addChild(GShape());
    rectangle.graphics.beginFill(Colors.blue).drawRect(0, 0, 50, 20).endFill();
    rectangle.x = 130;
    rectangle.y = 190;
    pulseCircle();
    pulseRect();
  }

  void pulseRect() {
    rectangle.tween(
      duration: 1,
      scaleX: 1.5,
      scaleY: 1.5,
      ease: GEase.easeInOut,
      onComplete: () {
        rectangle.tween(
          duration: 1,
          scaleX: 1,
          scaleY: 1,
          ease: GEase.easeInOut,
          onComplete: pulseRect,
        );
      },
    );
  }

  void pulseCircle() {
    circle.tween(
      duration: 1,
      scaleX: 1.5,
      scaleY: 1.5,
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
