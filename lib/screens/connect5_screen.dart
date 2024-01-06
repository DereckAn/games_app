import 'package:flutter/material.dart';

class Connect5 extends StatefulWidget {
  const Connect5({super.key});

  @override
  State<Connect5> createState() => _Connect4State();
}

class _Connect4State extends State<Connect5> {
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
