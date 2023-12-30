import 'dart:ui';

import 'package:flame/components.dart';

class CircleRotator extends PositionComponent {
  CircleRotator(
      {required super.size, required super.position, this.thinkness = 8})
      : assert(size!.x == size.y),
        super(anchor: Anchor.center);

  final double thinkness;

  @override
  void render(Canvas canvas) {
    final radius = (size.x / 2) - (thinkness / 2);
    super.render(canvas);
    canvas.drawCircle(
        (size/2).toOffset(),
        radius,
        Paint()
          ..color = const Color.fromARGB(255, 39, 206, 212)
          ..style = PaintingStyle.stroke
          ..strokeWidth = thinkness);
  }
}
