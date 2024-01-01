import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class StarPoints extends PositionComponent {
  late Sprite _starSprite;

  StarPoints({
    required super.position,
  }) : super(size: Vector2(40, 40), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _starSprite = await Sprite.load('star.png');
    add(CircleHitbox(radius: size.x / 2, collisionType: CollisionType.passive));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _starSprite.render(canvas,
        size: size, position: size / 2, anchor: Anchor.center);
  }
}
