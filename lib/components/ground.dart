import 'dart:async';

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

  late Sprite finerSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    finerSprite = await Sprite.load('finger.png');
    // add( // Esta es una manera de poner una imagen
    //   SpriteComponent(
    //     sprite: finerSprite,
    //     size: Vector2(100, 100),
    //   ),
    // );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // canvas.drawRect(
    //     Rect.fromLTWH(0, 0, width, height), Paint()..color = Colors.red);

    finerSprite.render(canvas, size: Vector2(100, 100), position: Vector2(210, -80)); // Esta es otra manera de poner una imagen
  }
}
