import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ColorSwitcherScreen extends StatefulWidget {
  const ColorSwitcherScreen({super.key});

  @override
  State<ColorSwitcherScreen> createState() => _ColorSwitcherScreenState();
}

class _ColorSwitcherScreenState extends State<ColorSwitcherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: MyGame()),
    );
  }
}

class MyGame extends FlameGame with TapCallbacks {
  late ColorSwitcher myPlayer;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 220, 4, 4);
  }

  @override
  void onMount() {
    add(myPlayer = ColorSwitcher());
    super.onMount();
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }
}

class ColorSwitcher extends PositionComponent {
  final velocity = Vector2(0, 30.0);
  final double gravity = 980.0;
  final double jumpVelocity = 300.0;

  @override
  void onMount() {
    position = Vector2(100, 100);
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
    velocity.y += gravity * dt;
  }

  @override
  void render(Canvas canvas) {
    // Esta función se llama cada vez que se actualiza el juego (60 veces por segundo) FPS
    super.render(canvas);

    canvas.drawCircle(position.toOffset(), 20,
        Paint()..color = const Color.fromARGB(255, 39, 206, 212));
    //Paint paint = Paint();
    // paint.color = const Color.fromARGB(255, 39, 206, 212);
  }

  void jump() {
    velocity.y = -jumpVelocity;
  }
}
