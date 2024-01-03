import 'dart:math' as math;

import 'package:app_juegos/components/color_switcher.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';


class XRotator extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
      
  final List<Color> listColors;
  final double thinkness;
  final double speed;
  final Paint paint = Paint();

  XRotator({
    required Vector2 size,
    required Vector2 position,
    required this.listColors,
    this.thinkness = 10,
    this.speed = 2,
  })  : assert(size.x == size.y),
        super(size: size, position: position, anchor: Anchor.center); // Remove super.listColors from here


  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
  Rect.fromPoints(const Offset(10,10), const Offset(500,500)),
  paint..color = Colors.blue,
);


  }
}
