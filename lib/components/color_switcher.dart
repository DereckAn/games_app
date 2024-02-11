import 'dart:math';

import 'package:app_juegos/components/blue_ball_player.dart';
import 'package:app_juegos/components/color_changer.dart';
import 'package:app_juegos/components/ground.dart';
import 'package:app_juegos/components/rotator_circular.dart';
import 'package:app_juegos/components/rotator_x.dart';
import 'package:app_juegos/components/star_points.dart';
import 'package:app_juegos/constants/change_colors.dart';
import 'package:app_juegos/widgets/game_over_dialog.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale {
  late Player myPlayer;
  final random = Random();
  late double lastObstaclePosition = 0;
  final ValueNotifier<int> currentScore = ValueNotifier<int>(0);
  final BuildContext context;
  late List<Color> selectedColors;
  late Color selectedColor;
  final List<PositionComponent> _obstacles = [];

  MyGame(this.context)
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
  Future<void> onLoad() async {
    await super.onLoad();
    decorator = PaintDecorator.blur(0);
    await Flame.images.loadAll([
      'finger.png',
      'star.png',
    ]);
    await FlameAudio.audioCache.loadAll([
      'burbuja.mp3',
    ]);
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
    // camera.viewfinder.zoom = 0.1;

    super.update(dt);
  }

  // void _addCicularObstacles() {
  //   generatingcolors();
  //   // List<Color> selectedColors = getSelectedColors();
  //   // Guarda el color seleccionado en una variable.
  //   // Color selectedColor = selectedColors[random.nextInt(selectedColors.length)];
  //   // debugMode = true;
  //   // Asegúrate de que los obstáculos se agreguen en la posición correcta
  //   world.add(CircleRotator(
  //       position: Vector2(0, 0),
  //       size: Vector2(200, 200),
  //       listColors: selectedColors));
  //   world.add(StarPoints(position: Vector2(0, 0)));
  //   world.add(ColorChanger(position: Vector2(0, 200), color: selectedColor));

  //   world.add(XRotator(
  //       listColors: selectedColors,
  //       speed: 1.5,
  //       position: Vector2(0, -500),
  //       size: Vector2(300, 300)));
  //   world.add(StarPoints(position: Vector2(0, -500)));
  // }

  void generatingcolors() {
    selectedColors = getSelectedColors();
    // Guarda el color seleccionado en una variable.
    selectedColor = selectedColors[random.nextInt(selectedColors.length)];
  }


  void _obstacle1(Vector2 distance) {
    generatingcolors();
    _addObstacle(CircleRotator(
        position: Vector2(0, 0) + distance,
        size: Vector2(200, 200),
        listColors: selectedColors));
    _addObstacle(StarPoints(position: Vector2(0, 0) + distance));
    _addObstacle(ColorChanger(
        position:  Vector2(0, 200) + distance, color: selectedColor));
  }

  void _obstacle2(Vector2 distance) {
    generatingcolors();
    _addObstacle(XRotator(
        listColors: selectedColors,
        speed: 1.5,
        position: Vector2(0, -400) + distance,
        size: Vector2(300, 300)));
    _addObstacle(StarPoints(position: Vector2(0, -400) + distance));
  }

  void _obstacle3(Vector2 distance) {
    generatingcolors();
    _addObstacle(CircleRotator(
        position: Vector2(0, -900) + distance,
        size: Vector2(200, 200),
        listColors: selectedColors));
    _addObstacle(CircleRotator(
        position: Vector2(0, -900) + distance,
        size: Vector2(250, 250),
        listColors: selectedColors));
    _addObstacle(StarPoints(position: Vector2(0, -900) + distance));
    _addObstacle(ColorChanger(
        position: Vector2(0, -700) + distance, color: selectedColor));
  }

  void _addObstacle(PositionComponent obstacle) {
    _obstacles.add(obstacle);
    world.add(obstacle);
  }

  void _generatingObstacles(Vector2 distance) {
    _obstacle1(distance);
    _obstacle2(distance);
    _obstacle3(distance);
  }

  void gameOver() {
    for (var element in world.children) {
      element.removeFromParent();
    }
    // world.add(FlameGameOver(
    //     position: Vector2(0, 0), gameOverSize: 500));
    // pauseGame();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameOverDialog(
          points: currentScore.value,
          startGame: initilizeGame,
        );
      },
    );
  }

  void initilizeGame() {
    currentScore.value = 0;
    world.add(Ground(position: Vector2(0, 480)));
    world.add(myPlayer = Player(position: Vector2(0, 300)));
    // debugMode = true;
    // _addCicularObstacles();
    lastObstaclePosition = myPlayer.position.y;
    camera.moveTo(Vector2.zero());
    _generatingObstacles(Vector2.zero());
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

  void checkToGenerateNextSetObstables(StarPoints startComponets ) {
    final allStartPoints = _obstacles.whereType<StarPoints>().toList( );
    final length = allStartPoints.length;
    for (var i = 0; i < allStartPoints.length; i++) {
      if(startComponets == allStartPoints[i] && i >= length - 2) {
        final lastStart = allStartPoints.last;
        _generatingObstacles(lastStart.position - Vector2(0, 400));
        _tryGrabageCollector(startComponets);
      }
    }
  }
  
  void _tryGrabageCollector(StarPoints startComponets) {
    for(int i=0; i < _obstacles.length; i++) {
      if(_obstacles[i] == startComponets && i >= 13) {
        _removeComponents(i-7);
        break;
      }
    }
  }
  
  void _removeComponents(int i) {
    for(int j = i -1; j >= 0; j--) {
      _obstacles[j].removeFromParent();
      _obstacles.removeAt(j);
    }
  }
}
