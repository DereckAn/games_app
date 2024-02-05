import 'package:app_juegos/constants/change_colors.dart';
import 'package:flutter/material.dart';

class ColorMatcherGame extends StatefulWidget {
  const ColorMatcherGame({super.key});

  @override
  State<ColorMatcherGame> createState() => _ColorMatcherGameState();
}

class _ColorMatcherGameState extends State<ColorMatcherGame> {
  MapEntry<Color, String> _backgroundColor = getSelectedColor();

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
                getSelectedColor().value, style: const TextStyle(fontSize: 50),
              ),
            ),
            IconButton(
              color: const Color.fromARGB(255, 10, 108, 13),
              iconSize: 50,
              onPressed: () {
                setState(() {
                  _backgroundColor = getSelectedColor();
                });
              },
              icon: const Icon(Icons.check),
            ),
            IconButton(
              color: const Color.fromARGB(255, 163, 18, 8),
              iconSize: 50,
              onPressed: () {
                setState(() {
                  _backgroundColor = getSelectedColor();
                });
              },
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
      ),
    );
  }
}
