import 'package:app_juegos/constants/change_colors.dart';
import 'package:app_juegos/widgets/button.dart';
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
        decoration:  BoxDecoration(
          gradient: LinearGradient(
              colors: getSelectedColors(),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset(
                'assets/images/pato.png',
                width: 300,
                height: 300,
              ),
            ),
            ButtonMenu(
              text: 'Start',
              onPressed: () {
                Navigator.pushNamed(context, '/colormatchergame');
              },
            ),
          ],
        ),
      ),
    );
  }
}
