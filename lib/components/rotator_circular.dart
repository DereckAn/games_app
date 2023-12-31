import 'dart:math';

import 'package:app_juegos/components/color_switcher.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class CircleRotator extends PositionComponent with HasGameRef<MyGame> {
  CircleRotator(
      {required super.size, required super.position, this.thinkness = 8, this.speed = 2})
      : assert(size!.x == size.y),
        super(anchor: Anchor.center);

  final double thinkness;
  final double speed;

  @override
  void onLoad() {
    super.onLoad();
    List<Color> colorsCopy = List<Color>.from(gameRef.colors);
    colorsCopy.shuffle();
    List<Color> selectedColors = colorsCopy.take(4).toList();

    for (int i = 0; i < selectedColors.length; i++) {
      add(CircularArc(
        color: selectedColors[i],
        firstAngle: (i * 2 * pi) / selectedColors.length,
        secondAngle: (2 * pi) / selectedColors.length,
      ));
    }
    add(RotateEffect.to(
        2 * pi,
        EffectController(
            infinite: true, speed: speed))); //  Esta es otra manera de rotarlo
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
  }) : super(anchor: Anchor.center);

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

  // @override  // Esta es una manera de rotarlo
  // void update(double dt) {
  //   super.update(dt);
  //   angle += dt; // Angle ya viene en el componente. No tenemos que instanciarlo.
  // }
}
