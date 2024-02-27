import 'package:app_juegos/provider/room_data_provider.dart';
import 'package:app_juegos/screens/color_switch_screen.dart';
import 'package:app_juegos/screens/colormatcher_game_screen.dart';
import 'package:app_juegos/screens/connect5_screen.dart';
import 'package:app_juegos/screens/create_tic_tac_toe.dart';
import 'package:app_juegos/screens/flapy_bird_screen.dart';
import 'package:app_juegos/screens/home.dart';
import 'package:app_juegos/screens/join_tic_tac_toe.dart';
import 'package:app_juegos/screens/memory_screen.dart';
import 'package:app_juegos/screens/screen_2048.dart';
import 'package:app_juegos/screens/snake_screen.dart';
import 'package:app_juegos/screens/tetris_screen.dart';
import 'package:app_juegos/screens/tic_tac_toe_game_screen.dart';
import 'package:app_juegos/screens/tic_tac_toe_screen.dart';
import 'package:app_juegos/screens/colormatcher_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Esto es cuando solo tengamos un provider pero en el futuro tendremos mas. Y para eso utilizaremos multiprovider
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
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
          '/creategame': (context) => const CreateTicTacToeGame(),
          '/joingame': (context) => const JoinTivTacToe(),
          '/playingTTT': (context) => const TicTacToeGame(),
          '/colormatcher': (context) => const ColorMatcherScreen(),
          '/colormatchergame': (context) => const ColorMatcherGame(),
          '/flappybirdgame': (context) => const FlappyBirdScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 23, 23, 23),
              secondary: Colors.blue,
              surface: Color.fromRGBO(24, 122, 148, 1),
              background: Color.fromARGB(255, 28, 37, 45),
              onBackground: Colors.white70),
          useMaterial3: true,
        ),
      ),
    );
  }
}
