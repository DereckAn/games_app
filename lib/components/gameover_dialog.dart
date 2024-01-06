import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FlameGameOver extends PositionComponent {
  FlameGameOver({required super.position, required this.gameOverSize}) : super(priority: 20);

  final double gameOverSize;
  late Paint _paint;

  @override
  void onMount() {
    size = Vector2.all(gameOverSize * 2);
    anchor = Anchor.center;
    _paint = Paint()..color = Colors.red;
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final rect = Rect.fromCenter(
      center: (size / 2).toOffset(),
      width: gameOverSize,
      height: gameOverSize,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));
    canvas.drawRRect(rrect, _paint);
  }
}
