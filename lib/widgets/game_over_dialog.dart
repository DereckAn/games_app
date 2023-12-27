import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    Key? key,
    this.points = 0,
    required this.startGame,
    this.initializeGame,
  }) : super(key: key);

  final int? points;
  final Function? initializeGame;
  final Function startGame;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text(
        'Game Over',
        style: TextStyle(color: Colors.red),
      ),
      content: Text('Total Score: $points \n Play Again?'),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Yes',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          onPressed: () {
            initializeGame?.call();
            startGame();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'No',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
