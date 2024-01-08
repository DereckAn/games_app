import 'package:app_juegos/widgets/button.dart';
import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonMenu(text: 'Hola perro', onPressed: () {  }, ),
          const SizedBox(height: 20),
          ButtonMenu(text: 'Adios gato', onPressed: () {  }, ),
        ],
      )
    );
  }
}