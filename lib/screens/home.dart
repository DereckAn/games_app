import 'package:app_juegos/widgets/choose_game_button_w.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20.0), // here the desired height
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      body: Center(
        child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: const [
          ChooseGameButtonW(
              gameName: 'Connect 5',
              routeSvg: 'assets/svg/connect.svg',
              gameRoute: '/connect4'),
          ChooseGameButtonW(
              gameName: 'Tetris',
              routeSvg: 'assets/svg/tetris-app-24-filled.svg',
              gameRoute: '/tetris'),
          ChooseGameButtonW(
              gameName: 'Snake',
              routeSvg: 'assets/svg/snake.svg',
              gameRoute: '/snake'),
          ChooseGameButtonW(
              gameName: '2048',
              routeSvg: 'assets/svg/2048-game.svg',
              gameRoute: '/2048'),
          ChooseGameButtonW(
              gameName: 'Memory',
              routeSvg: 'assets/svg/memory.svg',
              gameRoute: '/memory'),
        ],
      ),
    ),
  ],
),
      ),
    );
  }
}
