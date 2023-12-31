import 'dart:math';

import 'package:app_juegos/components/color_switcher.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CircleRotator extends PositionComponent with HasGameRef<MyGame> {
  CircleRotator(
      {required super.size, required super.position, this.thinkness = 8})
      : assert(size!.x == size.y),
        super(anchor: Anchor.center);

  final double thinkness;

  @override
  void onLoad() {
    super.onLoad();

    for(int i = 0; i < gameRef.colors.length; i++) {
      add(CircularArc(
        color: gameRef.colors[i],
        firstAngle: (i * 2 * pi) / gameRef.colors.length,
        secondAngle: (2 * pi) / gameRef.colors.length,
      ));
    }

    // add(CircularArc(
    //   color: gameRef.colors[0],
    //   firstAngle: 0,
    //   secondAngle: 1,
    // ));
  }

  @override
  void render(Canvas canvas) {
    final radius = (size.x / 2) - (thinkness / 2);
    super.render(canvas);
  }
}

class CircularArc extends PositionComponent with ParentIsA<CircleRotator> {
  final Color color;
  final double firstAngle;
  final double secondAngle;

  CircularArc({
    required this.color,
    required this.firstAngle,
    required this.secondAngle,
  }):super(anchor: Anchor.center);

  @override
  void onMount() {
    super.onMount();
    size = parent.size;
    position = size / 2;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawArc(
        size.toRect().deflate(parent.thinkness / 2),
        firstAngle,
        secondAngle,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = parent.thinkness);
  }
}
