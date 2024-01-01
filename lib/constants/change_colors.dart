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

List<Color> getSelectedColors() {
  List<Color> modifiableColors = List.from(colors);
  modifiableColors.shuffle();
  return modifiableColors.take(4).toList();
}