import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent {
  static const String groundName = 'ground_key_blabla';
  Ground({required super.position})
      : super(
          size: Vector2(500, 3),
          anchor: Anchor
              .center, // Esto es para que este en el centro de la pantalla
          key: ComponentKey.named(groundName),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height), Paint()..color = Colors.red);
  }
}
