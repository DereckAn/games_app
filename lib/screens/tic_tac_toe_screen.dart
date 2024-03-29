import 'package:app_juegos/responsive/responsive.dart';
import 'package:app_juegos/widgets/button.dart';
import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  // void createRoom(BuildContext context) {
  //   Navigator.pushNamed(context, '/creategame');
  // }

  // void joinRoom(BuildContext context) {
  //   Navigator.pushNamed(context, '/joingame');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
        ),
        body: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonMenu(
                text: 'Create Game',
                onPressed: () => Navigator.pushNamed(context, '/creategame'),
              ),
              const SizedBox(height: 20),
              ButtonMenu(
                text: 'Join Game',
                onPressed: () => Navigator.pushNamed(context, '/joingame'),
              ),
            ],
          ),
        ));
  }
}
