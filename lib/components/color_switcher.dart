import 'dart:math';

import 'package:app_juegos/components/blue_ball_player.dart';
import 'package:app_juegos/components/color_changer.dart';
import 'package:app_juegos/components/ground.dart';
import 'package:app_juegos/components/rotator_circular.dart';
import 'package:app_juegos/components/star_points.dart';
import 'package:app_juegos/constants/change_colors.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale {
  late Player myPlayer;
  final random = Random();
  ValueNotifier<int> currentScore = ValueNotifier<int>(0);

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
  void onLoad() {
    decorator = PaintDecorator.blur(0);
    super.onLoad();
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
    List<Color> selectedColors = getSelectedColors();

    // Guarda el color seleccionado en una variable.
    Color selectedColor = selectedColors[random.nextInt(selectedColors.length)];

    world.add(CircleRotator(
        position: Vector2.zero(),
        size: Vector2(200, 200),
        listColors: selectedColors));
    world.add(StarPoints(position: Vector2(0, 0)));

    world.add(ColorChanger(position: Vector2(0, 200), color: selectedColor));
  }

  void gameOver() {
    for (var element in world.children) {
      element.removeFromParent();
    }
    initilizeGame();
  }

  void initilizeGame() {
    currentScore.value = 0;
    world.add(Ground(position: Vector2(0, 480)));
    world.add(myPlayer = Player(position: Vector2(0, 300)));
    // debugMode = true;
    _addCicularObstacles();
    camera.moveTo(Vector2.zero());
  }

  bool get isGamePause => timeScale == 0;
  bool get isPlaying => !isGamePause;

  void pauseGame() {
    (decorator as PaintDecorator).addBlur(10);
    timeScale = 0;
    // pauseEngine();
  }

  void resumeGame() {
    (decorator as PaintDecorator).addBlur(0);
    timeScale = 1;
    // resumeEngine();
  }

  void totalScore() {
    currentScore.value++;
  }
}
