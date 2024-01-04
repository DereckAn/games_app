import 'package:app_juegos/components/color_changer.dart';
import 'package:app_juegos/components/color_switcher.dart';
import 'package:app_juegos/components/ground.dart';
import 'package:app_juegos/components/rotator_circular.dart';
import 'package:app_juegos/components/rotator_x.dart';
import 'package:app_juegos/components/star_points.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  Player({required super.position, this.playerSize = 20}) : super(priority: 20);

  final velocity = Vector2.zero();
  final double gravity = 980.0;
  final double jumpVelocity = 300.0;
  final double playerSize;
  late Paint _paint;
  late double collisionCooldown = 0.0;


  Color color = Colors.blue;

  @override
  void onMount() {
    size = Vector2.all(playerSize * 2);
    anchor = Anchor.center;
    _paint = Paint()..color = color;
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    Ground ground = gameRef.findByKeyName(Ground.groundName)!;
    double groundPositionY = positionOfAnchor(Anchor.bottomCenter).y;
    if (groundPositionY > ground.position.y) {
      velocity.setValues(0, 0);
      position = Vector2(0, ground.position.y - playerSize);
    } else {
      velocity.y += gravity * dt;
    }

    if (collisionCooldown > 0) {
      collisionCooldown -= dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle((size / 2).toOffset(), playerSize, _paint);
  }

  void jump() {
    velocity.y = -jumpVelocity;
  }

  @override
  void onLoad() {
    add(CircleHitbox(
        radius: playerSize,
        anchor: anchor,
        collisionType: CollisionType.active));
    super.onLoad();
    // decorator.addLast(PaintDecorator.blur(3.0));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ColorChanger) {
      other.removeFromParent();
      color = other.color;
      _paint.color = color;
      collisionCooldown = 0.5;  // Ignora las colisiones durante 0.5 segundos
    } else if (other is CircularArc && collisionCooldown <= 0) {
      if (color != other.color) {
        gameRef.gameOver();
      }
    } else if (other is StarPoints) {
      other.collectionAnimation();
      gameRef.totalScore();
      FlameAudio.play('burbuja.mp3');
    } else if (other is RectanglePart && collisionCooldown <= 0) {
      if (color != other.color) {
        gameRef.gameOver();
      }
    }
  }
}
