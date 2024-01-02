import 'dart:math' as math;

import 'package:app_juegos/components/color_switcher.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class CircleRotator extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
      
  final List<Color> listColors;
  final double thinkness;
  final double speed;

  CircleRotator({
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

    for (int i = 0; i < listColors.length; i++) {
      add(CircularArc(
        color: listColors[i],
        firstAngle: (i * 2 * math.pi) / listColors.length,
        secondAngle: (2 * math.pi) / listColors.length,
      ));
    }
    add(
      RotateEffect.to(
        2 * math.pi,
        EffectController(infinite: true, speed: speed),
      ),
    );
  }
}

class CircularArc extends PositionComponent with ParentIsA<CircleRotator> {
  final Color color;
  final double firstAngle;
  final double secondAngle;
  final Paint paint = Paint();


  CircularArc({
    required this.color,
    required this.firstAngle,
    required this.secondAngle,
  }) : super(anchor: Anchor.center);

  @override
  void onMount() {
    super.onMount();
    size = parent.size;
    position = size / 2;

    addHitbox();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawArc(
        size.toRect().deflate(parent.thinkness / 2),
        firstAngle,
        secondAngle,
        false,
        paint
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = parent.thinkness);
  }

  void addHitbox() {
    final center = size / 2;
    const precision = 8;
    final segment = secondAngle / (precision - 1);
    final radius = center.x;

    List<Vector2> points = [];
    for (int i = 0; i < precision; i++) {
      final segmento = firstAngle + segment * i;
      final cosSegmento = math.cos(segmento);
      final sinSegmento = math.sin(segmento);
      points.add(center + Vector2(cosSegmento, sinSegmento) * radius);
    }

    for (int i = precision - 1; i >= 0; i--) {
      final segmento = firstAngle + segment * i;
      final cosSegmento = math.cos(segmento);
      final sinSegmento = math.sin(segmento);
      points.add(center +
          Vector2(cosSegmento, sinSegmento) * (radius - parent.thinkness));
    }

    add(PolygonHitbox(points, collisionType: CollisionType.passive));
  }
}
