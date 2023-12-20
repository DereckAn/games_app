import 'package:flutter/material.dart';

class ChooseGameButtonW extends StatelessWidget {
  const ChooseGameButtonW(
      {required this.gameName,
      required this.gameRoute,
      required this.gameIcon,
      super.key});
  final String gameName;
  final String gameRoute;
  final IconData gameIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      // style: TextButton.styleFrom(,
        onPressed: () {
          Navigator.pushNamed(context, gameRoute);
        },
        icon: Icon(gameIcon, color: Theme.of(context).colorScheme.secondary),
        label: Text(gameName, style: TextStyle(color: Theme.of(context).colorScheme.secondary)));
  }
}
