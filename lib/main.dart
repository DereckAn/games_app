import 'package:app_juegos/screens/connect4_screen.dart';
import 'package:app_juegos/screens/home.dart';
import 'package:app_juegos/screens/screen_2048.dart';
import 'package:app_juegos/screens/snake_screen.dart';
import 'package:app_juegos/screens/tetris_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/connect4': (context) => const Connect4(),
        '/tetris': (context) => const TetrisScreen(),
        '/snake': (context) => const SnakeScreen(),
        '/2048': (context) => const Screen2048(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 9, 44, 63)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
