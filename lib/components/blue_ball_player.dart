import 'package:app_juegos/components/color_switcher.dart';
import 'package:app_juegos/components/ground.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameRef<MyGame> {
  Player({this.playerSize = 20});

  final velocity = Vector2.zero();
  final double gravity = 980.0;
  final double jumpVelocity = 300.0;
  final double playerSize;

  @override
  void onMount() {
    position = Vector2.zero();
    size = Vector2.all(playerSize * 2);
    anchor = Anchor.center;
    debugMode = true;
    super.onMount();
  }

  @override
  void update(double dt) {
    // delta time is the time between frames. How much time has passed since the last update.
    // 60 FPS = 1/60 = 0.0166666666666667 = dt
    // 120 FPS = 1/120 = 0.0083333333333333 = dt
    // Esta función se llama cada vez que se actualiza el juego (60 veces por segundo) FPS
    super.update(dt);
    position += velocity * dt;

    Ground ground = gameRef.findByKeyName(Ground.groundName)!;
    if (positionOfAnchor(Anchor.bottomCenter).y > ground.position.y) {
      velocity.setValues(0, 0);
      position = Vector2(0, ground.position.y - playerSize);
    } else {
      velocity.y += gravity * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    // Esta función se llama cada vez que se actualiza el juego (60 veces por segundo) FPS
    super.render(canvas);
    canvas.drawCircle((size / 2).toOffset(), playerSize,
        Paint()..color = const Color.fromARGB(255, 39, 206, 212));
    //Paint paint = Paint();
    // paint.color = const Color.fromARGB(255, 39, 206, 212);
  }

  void jump() {
    velocity.y = -jumpVelocity;
  }
}
