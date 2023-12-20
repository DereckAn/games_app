import 'package:flutter/material.dart';

class Connect4 extends StatefulWidget {
  const Connect4({super.key});

  @override
  State<Connect4> createState() => _Connect4State();
}

class _Connect4State extends State<Connect4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect 4'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connect 4',
            ),
          ],
        ),
      ),
    );
  }
}
