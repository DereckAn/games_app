import 'package:app_juegos/constants/change_colors.dart';
import 'package:flutter/material.dart';

class ColorMatcherScreen extends StatelessWidget {
  const ColorMatcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Matcher'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: listadecolores,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: const Center(
          child: Text('Color Matcher'),
        ),
      ),
    );
  }
}
