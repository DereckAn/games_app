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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ChooseGameButtonW(
                gameIcon: Icons.connect_without_contact_sharp,
                gameName: 'Connect 4',
                gameRoute: '/connect4'),
            ChooseGameButtonW(
                gameIcon: Icons.text_fields_rounded,
                gameName: 'Tetris',
                gameRoute: '/tetris'),
            ChooseGameButtonW(
                gameIcon: Icons.sync_alt_sharp,
                gameName: 'Snake',
                gameRoute: '/snake'),
            ChooseGameButtonW(
                gameIcon: Icons.sync_alt_sharp,
                gameName: '2048',
                gameRoute: '/2048'),
            // ChooseGameButtonW(
            //     gameIcon: Icons.sync_alt_sharp,
            //     gameName: 'Prueba',
            //     gameRoute: '/prueba'),
          ],
        ),
      ),
    );
  }
}
