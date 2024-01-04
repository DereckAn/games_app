
import 'package:app_juegos/components/color_switcher.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';


class MovingSquare extends PositionComponent with HasGameRef<MyGame>, CollisionCallbacks {
  final double speed;
  final Paint paint = Paint();

  MovingSquare({
    required Vector2 size,
    required Vector2 position,
    this.speed = 100,
  }) : super(size: size, position: position, anchor: Anchor.center);

  @override
  void update(double dt) {
    super.update(dt);
    // Mueve el cuadrado de arriba a abajo
    position.y += speed * dt;
    if (position.y > gameRef.size.y) {
      position.y = -size.y;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), paint..color = Colors.green);
  }
}
