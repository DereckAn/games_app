import 'dart:math' as math;

import 'package:app_juegos/components/color_switcher.dart';
import 'package:app_juegos/constants/change_colors.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ColorChanger extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  ColorChanger({required super.position, required this.color, this.radius = 25})
      : super(size: Vector2.all(radius * 2), anchor: Anchor.center);

  final double radius;
  final Color color;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final length = colors.length;
    final colorAngle = (math.pi * 2) / length;

    for (int i = 0; i < length; i++) {
      canvas.drawArc(size.toRect(), i * colorAngle, colorAngle, true,
          Paint()..color = colors[i]);
    }
  }

  @override
  void onLoad() {
    add(CircleHitbox(radius: radius, anchor: anchor, position: size / 2, collisionType: CollisionType.passive));
    super.onLoad();
  }
}
