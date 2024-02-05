import 'dart:math';

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

final Map<Color, String> colorNames = {
  Colors.blue: 'blue',
  Colors.red: 'red',
  Colors.green: 'green',
  Colors.purple: 'purple',
  Colors.orange: 'orange',
  Colors.pink: 'pink',
  Colors.teal: 'teal',
  Colors.cyan: 'cyan',
  Colors.lime: 'lime',
  Colors.amber: 'yellow',
  Colors.indigo: 'indigo',
  Colors.brown: 'brown',
  Colors.grey: 'grey',
};

List<Color> getSelectedColors() {
  List<Color> modifiableColors = List.from(colors);
  modifiableColors.shuffle();
  return modifiableColors.take(4).toList();
}

// MapEntry<Color, String> getSelectedColor() {
//   List<MapEntry<Color, String>> colorsList = colorNames.entries.toList();
//   colorsList.shuffle();
//   return colorsList.first;
// }

Random random = Random();
MapEntry<Color, String> getSelectedColor() {
  List keys = colorNames.keys.toList();
  Color randomColor = keys[random.nextInt(keys.length)];
  return MapEntry(randomColor, colorNames[randomColor].toString());
}
