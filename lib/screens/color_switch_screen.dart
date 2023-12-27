import 'package:flutter/material.dart';

class ColorSwitcherScreen extends StatefulWidget {
  const ColorSwitcherScreen({super.key});

  @override
  State<ColorSwitcherScreen> createState() => _ColorSwitcherScreenState();
}

class _ColorSwitcherScreenState extends State<ColorSwitcherScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('Color Switcher'),
      ),);
  }
}