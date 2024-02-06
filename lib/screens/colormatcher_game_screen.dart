import 'package:app_juegos/constants/change_colors.dart';
import 'package:flutter/material.dart';

class ColorMatcherGame extends StatefulWidget {
  const ColorMatcherGame({super.key});

  @override
  State<ColorMatcherGame> createState() => _ColorMatcherGameState();
}

class _ColorMatcherGameState extends State<ColorMatcherGame> {
  MapEntry<Color, String> _backgroundColor = getSelectedColor();
  MapEntry<Color, String> _colorName = getSelectedColor();
  int _score = 0;
  bool _doColorsMatch = false;

  @override
  void initState() {
    super.initState();
    _doColorsMatch = doColorMatch();
  }

  void generateAnotherColor() {
    setState(() {
      _backgroundColor = getSelectedColor();
      _colorName = getSelectedColor();
      _doColorsMatch = doColorMatch();
    });
  }

  bool doColorMatch() {
    return _backgroundColor.key == _colorName.key;
  }

  void resetGame() {
    setState(() {
      _score = 0;
      _backgroundColor = getSelectedColor();
      _colorName = getSelectedColor();
      _doColorsMatch = doColorMatch();
    });
  }

  void updateScore() {
    setState(() {
      _score++;
    });
  }

  void gameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your score is $_score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Matcher'),
      ),
      body: Container(
        color: _backgroundColor.key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                "${_colorName.value}  $_doColorsMatch $_score",
                style: const TextStyle(fontSize: 50),
              ),
            ),
            IconButton(
              color: const Color.fromARGB(255, 10, 108, 13),
              iconSize: 50,
              onPressed: () {
                if(_doColorsMatch == true){
                  generateAnotherColor();
                  _score++;
                }
              },
              icon: const Icon(Icons.check),
            ),
            IconButton(
              color: const Color.fromARGB(255, 163, 18, 8),
              iconSize: 50,
              onPressed: () {
                if(_doColorsMatch == false){
                  generateAnotherColor();
                  _score++;
                }
              },
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
      ),
    );
  }
}