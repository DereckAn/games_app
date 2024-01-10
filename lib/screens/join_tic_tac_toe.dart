import 'package:app_juegos/responsive/responsive.dart';
import 'package:app_juegos/widgets/button.dart';
import 'package:app_juegos/widgets/custome_text_field.dart';
import 'package:app_juegos/widgets/wloding_text.dart';
import 'package:flutter/material.dart';

class JoinTivTacToe extends StatefulWidget {
  const JoinTivTacToe({super.key});

  @override
  State<JoinTivTacToe> createState() => _JoinTivTacToeState();
}

class _JoinTivTacToeState extends State<JoinTivTacToe> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _iDcontroller = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _iDcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Tic Tac Toe Game'),
      ),
      body: Responsive(
        child: Container(
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
                  text: 'Join Game'),
              SizedBox(height: size.height * 0.2),
              CustomTextField(
                controller: _controller,
                hintText: 'Enter your username',
              ),
              SizedBox(height: size.height * 0.03),
               CustomTextField(
                controller: _iDcontroller,
                hintText: 'Enter game Id',
              ),
              SizedBox(height: size.height * 0.03),
              ButtonMenu(
                text: 'Join Game',
                onPressed: () {
                  Navigator.pushNamed(context, '/tictactoe');
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
