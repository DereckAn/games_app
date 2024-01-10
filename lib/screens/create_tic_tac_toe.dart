import 'package:app_juegos/widgets/wloding_text.dart';
import 'package:flutter/material.dart';

class CreateTicTacToeGame extends StatefulWidget {
  const CreateTicTacToeGame({super.key});

  @override
  State<CreateTicTacToeGame> createState() => _CreateTicTacToeGameState();
}

class _CreateTicTacToeGameState extends State<CreateTicTacToeGame> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Tic Tac Toe Game'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WlogingText(
                fontSize: 70,
                shadows: [
                  Shadow(
                      blurRadius: 40,
                      color: Theme.of(context).colorScheme.onBackground),
                ],
                text: 'Create Game'),
            SizedBox(height: size.height * 0.5),

          ],
        ),
      ),
    );
  }
}
 