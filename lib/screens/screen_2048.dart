import 'package:flutter/material.dart';

class Screen2048 extends StatefulWidget {
  const Screen2048({super.key});

  @override
  State<Screen2048> createState() => _Screen2048State();
}

class _Screen2048State extends State<Screen2048> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '2048',
            ),
          ],
        ),
      ),);
  }
}