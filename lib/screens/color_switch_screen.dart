import 'package:app_juegos/components/color_switcher.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ColorSwitcherScreen extends StatefulWidget {
  const ColorSwitcherScreen({super.key});

  @override
  State<ColorSwitcherScreen> createState() => _ColorSwitcherScreenState();
}

class _ColorSwitcherScreenState extends State<ColorSwitcherScreen> {
  late MyGame game;

  @override
  void initState() {
    super.initState();
    game = MyGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: game,
          ),
          if (game.isPlaying)
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  setState(
                    () {
                      game.pauseGame();
                    },
                  );
                },
              ),
            ),
          if (game.isGamePause)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'PAUSED!',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              game.resumeGame();
                            });
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            size: 100,
                          ),
                        ))
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
