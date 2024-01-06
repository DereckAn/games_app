import 'package:app_juegos/screens/color_switch_screen.dart';
import 'package:app_juegos/screens/connect5_screen.dart';
import 'package:app_juegos/screens/home.dart';
import 'package:app_juegos/screens/memory_screen.dart';
import 'package:app_juegos/screens/screen_2048.dart';
import 'package:app_juegos/screens/snake_screen.dart';
import 'package:app_juegos/screens/tetris_screen.dart';
import 'package:app_juegos/screens/tic_tac_toe_screen.dart';
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
        '/': (context) => const MyHomePage(),
        '/connect4': (context) => const Connect5(),
        '/tetris': (context) => const TetrisScreen(),
        '/snake': (context) => const SnakeScreen(),
        '/2048': (context) => const Screen2048(),
        '/memory': (context) => const MemoryScreen(),
        '/colorswitch': (context) => const ColorSwitcherScreen(),
        '/tictactoe': (context) => const TicTacToe(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 23, 23, 23),
          secondary: Colors.blue,
          surface: Color.fromRGBO(33, 33, 33, 1),
          background: Colors.blue,
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
