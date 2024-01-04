import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class XRotator extends PositionComponent with CollisionCallbacks {
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
  }) : super(size: size, position: position, anchor: Anchor.center);

  @override
  void onLoad() {
    super.onLoad();
    for (var i = 0; i < 4; i++) {
      add(RectanglePart(
          thinkness: thinkness,
          largo: size.y / 4,
          angle: i * pi / 2,
          color: listColors[i]));
    }
    add(
      RotateEffect.to(
        2 * pi,
        EffectController(infinite: true, speed: speed),
      ),
    );
  }
}

class RectanglePart extends PositionComponent with ParentIsA<XRotator> {
  final double thinkness;
  final double largo;
  final Color color;

  RectanglePart(
      {required this.thinkness,
      required this.largo,
      required double angle,
      required this.color}) {
    this.angle = angle;
  }

  @override
  void onMount() {
    super.onMount();
    size = parent.size / 2;
    position = parent.position + Vector2(parent.size.x / 2, parent.size.y / 2);
    addHitBox();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(size.x, 0, -largo, (thinkness / 2)),
      Paint()..color = color,
    );
  }

  void addHitBox() {
    add(RectangleHitbox(
        position: Vector2(size.x / 2, 0),
        size: Vector2(largo, (thinkness / 2)),
        collisionType: CollisionType.passive));
  }
}
