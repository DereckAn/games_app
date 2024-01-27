import 'package:flutter/material.dart';

class WaitingLobby extends StatelessWidget {
  const WaitingLobby({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Esperando a que se una otro jugador...',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ],
    );
  }
}
