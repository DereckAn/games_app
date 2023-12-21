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
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // print('screenWidth: $screenWidth');
    // print('screenHeight: $screenHeight');
    // print(
    //   MediaQuery.of(context).size.width ~/ 30,
    // );

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/connect4': (context) => const Connect4(),
        '/tetris': (context) => const TetrisScreen(),
        '/snake': (context) => const SnakeScreen(),
        '/2048': (context) => const Screen2048(),
        // '/prueba': (context) => const Prueba(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 23, 23, 23),
          secondary: Colors.blue,
          surface: Colors.blue,
          background: Colors.blue,
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
