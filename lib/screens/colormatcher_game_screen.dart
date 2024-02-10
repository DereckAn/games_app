import 'package:app_juegos/constants/change_colors.dart';
import 'package:app_juegos/widgets/game_over_dialog.dart';
import 'package:flutter/material.dart';

class ColorMatcherGame extends StatefulWidget {
  const ColorMatcherGame({super.key});

  @override
  State<ColorMatcherGame> createState() => _ColorMatcherGameState();
}

class _ColorMatcherGameState extends State<ColorMatcherGame>
    with SingleTickerProviderStateMixin {
  MapEntry<Color, String> _backgroundColor = getSelectedColor();
  MapEntry<Color, String> _colorName = getSelectedColor();
  int _score = 0;
  bool _doColorsMatch = false;
  double _timeLeft = 3;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _doColorsMatch = doColorMatch();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {
          _timeLeft =
              _controller.duration!.inSeconds * (1.0 - _controller.value);
          if (_timeLeft <= 0) {
            gameOver();
          }
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void restartTimer() {
    _timeLeft = 3;
    _controller.reset();
    _controller.forward();
  }

  void generateAnotherColor() {
    _backgroundColor = getSelectedColor();
    _colorName = getSelectedColor();
    _doColorsMatch = doColorMatch();
  }

  bool doColorMatch() {
    return _backgroundColor.key == _colorName.key;
  }

  void resetGame() {
    setState(() {
      _score = 0;
      generateAnotherColor();
    });
    restartTimer();
  }

  void gameOver() {
    _controller.reset();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GameOverDialog(
          points: _score,
          startGame: resetGame,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_score'),
      ),
      body: Container(
        color: _backgroundColor.key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            LinearProgressIndicator(
              value: _timeLeft / 3,
              color: Colors.green,
            ),
            Center(
              child: Text(
                _colorName.value,
                style: const TextStyle(fontSize: 50),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: const Color.fromARGB(255, 10, 108, 13),
                  iconSize: 50,
                  onPressed: () {
                    if (_doColorsMatch == true) {
                      generateAnotherColor();
                      _score++;
                      restartTimer();
                    } else {
                      gameOver();
                    }
                  },
                  icon: const Icon(Icons.check),
                ),
                IconButton(
                  color: const Color.fromARGB(255, 163, 18, 8),
                  iconSize: 50,
                  onPressed: () {
                    if (_doColorsMatch == false) {
                      generateAnotherColor();
                      _score++;
                      restartTimer();
                    } else {
                      gameOver();
                    }
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
