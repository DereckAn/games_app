import 'dart:math';

import 'package:app_juegos/components/blue_ball_player.dart';
import 'package:app_juegos/components/color_changer.dart';
import 'package:app_juegos/components/ground.dart';
import 'package:app_juegos/components/rotator_circular.dart';
import 'package:app_juegos/constants/change_colors.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player myPlayer;
  final random = Random();

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
    List<Color> selectedColors = getSelectedColors();

    // Guarda el color seleccionado en una variable.
    Color selectedColor = selectedColors[random.nextInt(selectedColors.length)];

    world.add(CircleRotator(
        position: Vector2.zero(),
        size: Vector2(200, 200),
        listColors: selectedColors));
    world.add(ColorChanger(
        position: Vector2(0, 200),
        color: selectedColor));  // Usa la variable aquí.
}


  void gameOver() {
    for (var element in world.children) {
      element.removeFromParent();
    }
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
