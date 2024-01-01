import 'package:app_juegos/components/blue_ball_player.dart';
import 'package:app_juegos/components/color_changer.dart';
import 'package:app_juegos/components/ground.dart';
import 'package:app_juegos/components/rotator_circular.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

const List<Color> colors = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.blueGrey,
  Colors.cyan,
  Colors.lime,
  Colors.amber,
  Colors.indigo,
  Colors.brown,
  Colors.grey,
];

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player myPlayer;

  MyGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );

  @override
  Color backgroundColor() => const Color.fromARGB(255, 32, 32, 32);

  @override
  void onMount() {
    initilizeGame();
    super.onMount();
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    if (myPlayer.position.y < camera.viewfinder.position.y) {
      camera.viewfinder.position = Vector2.zero()..y = myPlayer.position.y;
    }
    super.update(dt);
  }

  void _addCicularObstacles() {
    world.add(CircleRotator(position: Vector2.zero(), size: Vector2(200, 200)));
    world.add(ColorChanger(position: Vector2(0, 200), color: colors[0]));
  }

  void gameOver() {
    print('Game Over');
  }

  void initilizeGame() {
    world.add(Ground(position: Vector2(0, 480)));
    world.add(myPlayer = Player(position: Vector2(0, 300)));
    debugMode = true;
    _addCicularObstacles();
    camera.moveTo(Vector2.zero());
  }
}
