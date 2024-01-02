import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class StarPoints extends PositionComponent {
  late Sprite _starSprite;
  final Paint _paint = Paint();

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

  void collectionAnimation() {
    // Pon mucha atencion a esta fucnion porque son muchas animaciones en lazadas
    final rnd = Random();
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 80;
    parent!.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
          lifespan: 1,
          count: 30,
          generator: (i) {
            return AcceleratedParticle(
              // para que salgan disparadas
              speed: randomVector2(),
              acceleration: randomVector2(),
              child: RotatingParticle(
                // para que roten
                to: rnd.nextDouble() * pi * 2,
                child: ComputedParticle(renderer: (canvas, particle) {
                  // para que se hagan mas pequeñas
                  _starSprite.render(
                    canvas,
                    size: (size / 2) * (1 - particle.progress),
                    anchor: Anchor.center,
                    overridePaint: _paint
                      ..color = Colors.yellow.withOpacity(1 -
                          particle
                              .progress), // para que se hagan mas transparentes
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
    removeFromParent();
  }
}
