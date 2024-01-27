import 'package:app_juegos/provider/room_data_provider.dart';
import 'package:app_juegos/resources/socket_method.dart';
import 'package:app_juegos/widgets/poinst_board.dart';
import 'package:app_juegos/widgets/tictactoe_board.dart';
import 'package:app_juegos/widgets/waiting_lobby.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  final SocketMethod _socketMethod = SocketMethod();
  @override
  void initState() {
    super.initState();
    _socketMethod.updateRoomListener(context);
    _socketMethod.updatePlayersStateListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    // print(Provider.of<RoomDataProvider>(context).player1.username);
    // print(Provider.of<RoomDataProvider>(context).player2.username);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : const SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PointsBoard(),
                  TicTacToeBoard(),
                ],
              ),
            ),
    );
  }
}
