import 'package:app_juegos/components/color_switcher.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ColorSwitcherScreen extends StatelessWidget {
  const ColorSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context) => GameWidget(game: MyGame());
}