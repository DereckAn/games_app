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

const List<Color> listadecolores =  [
  Color.fromRGBO(136, 14, 79, 1),
  Colors.red,
  Color.fromARGB(255, 25, 121, 168),
  Colors.teal,
  Color.fromARGB(255, 145, 242, 26),
  Colors.amber
];

List<Color> getSelectedColors() {
  List<Color> modifiableColors = List.from(colors);
  modifiableColors.shuffle();
  return modifiableColors.take(4).toList();
}
