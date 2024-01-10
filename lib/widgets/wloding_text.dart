import 'package:flutter/material.dart';

class WlogingText extends StatelessWidget {
  final String text;
  final List<Shadow> shadows;
  final double fontSize;

  const WlogingText(
      {super.key,
      required this.text,
      required this.shadows,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        shadows: shadows,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
