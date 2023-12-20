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
        onPressed: () {
          Navigator.pushNamed(context, gameRoute);
        },
        icon: Icon(gameIcon),
        label: Text(gameName));
  }
}
