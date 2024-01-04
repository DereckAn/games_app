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
  }) : super(size: size, position: position, anchor: Anchor.center);

  @override
  void onLoad() {
    super.onLoad();
    add(RectangleComponent(thinkness: 10, largo: 130, position: Vector2(size.x / 2, 0)));
    // add(RectangleHitbox());
  }
}

class RectangleComponent extends PositionComponent with ParentIsA<XRotator> {
  final double thinkness;
  final double largo;

  RectangleComponent({required this.thinkness, required this.largo, required Vector2 position})
      : super(anchor: Anchor.centerRight, position: position);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
        Rect.fromPoints( Offset(-(thinkness/2), 0),  Offset((thinkness/2), largo)),
        Paint()..color = Colors.red);
  }

  @override
  void onLoad() {
    super.onLoad();
    add(RectangleHitbox());
  }
}