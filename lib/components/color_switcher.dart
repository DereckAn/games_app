import 'package:app_juegos/components/blue_ball_player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Player myPlayer;

  MyGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 32, 32, 32); // Set a fixed color
  }

  @override
  void onMount() {
    world.add(myPlayer = Player());
    // camera.follow(myPlayer);


    world.add(RectangleComponent()
      ..position = Vector2(100, 100)
      ..size = Vector2(100, 100)
      ..anchor = Anchor.center
      ..angle = 45
      );
    super.onMount();
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    final playerY = myPlayer.position.y;


    if(playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }
    super.update(dt);
  }
}

