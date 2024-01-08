import 'package:flutter/material.dart';

class ButtonMenu extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonMenu({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            minimumSize: Size(width, height / 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20), // Ajusta este valor para cambiar el radio de las esquinas
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          )),
    );
  }
}
