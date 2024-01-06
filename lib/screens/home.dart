import 'package:app_juegos/widgets/choose_game_button_w.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final games = const [
    {
      'name': 'Tic Tac Toe 5x5',
      'svg': 'assets/svg/connect.svg',
      'route': '/connect4'
    },{
      'name': 'Tic Tac Toe 3x3',
      'svg': 'assets/svg/connect.svg',
      'route': '/tictactoe'
    },
    {
      'name': 'Tetris',
      'svg': 'assets/svg/tetris-app-24-filled.svg',
      'route': '/tetris'
    },
    {'name': 'Snake', 'svg': 'assets/svg/snake.svg', 'route': '/snake'},
    {'name': '2048', 'svg': 'assets/svg/2048-game.svg', 'route': '/2048'},
    {'name': 'Memory', 'svg': 'assets/svg/memory.svg', 'route': '/memory'},
    {
      'name': 'Color Switch',
      'svg': 'assets/svg/slack.svg',
      'route': '/colorswitch'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: games.map((game) {
                  final name = game['name'];
                  final svg = game['svg'];
                  final route = game['route'];
                  if (name != null && svg != null && route != null) {
                    return ChooseGameButtonW(
                      gameName: name,
                      routeSvg: svg,
                      gameRoute: route,
                    );
                  } else {
                    throw Exception('Missing game data');
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
