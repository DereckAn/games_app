import 'package:app_juegos/provider/room_data_provider.dart';
import 'package:app_juegos/resources/socket_client.dart';
import 'package:app_juegos/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;

  // & Emisores
  void createGame(String username) {
    if (username.isNotEmpty) {
      _socketClient.emit('createGame', {'username': username});
    }
  }

  void joinGame(String username, String room) {
    if (username.isNotEmpty && room.isNotEmpty) {
      _socketClient.emit('joinGame', {'username': username, 'roomID': room});
    }
  }

  // & Listeners
  void createGameSuccessListener(BuildContext context) {
    _socketClient.on('createdGameSuccess', (room) {
      Navigator.pushNamed(context, '/playingTTT', arguments: room);
      print(room);
      Provider.of<RoomDataProvider>(context, listen: false).updateRoom(room);
    });
  }

  void joinGameRoomSuccess(BuildContext context) {
    _socketClient.on('joinGameRoomSuccess', (room) {
      Navigator.pushNamed(context, '/playingTTT', arguments: room);
      print(room);
      Provider.of<RoomDataProvider>(context, listen: false).updateRoom(room);
    });
  }

  void joinGameError(BuildContext context) {
    _socketClient.on('joinGameError', (error) {
      print(error);
      showSnackBar(context, error);
    });
  }

  // & Functions
  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerdata) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerdata[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerdata[1]); // cuidado con los index
    });
  }
}
