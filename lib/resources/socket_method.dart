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

  void tapGrid(int index, String roomID, List<String> elements) {
    if (elements[index] == '') {
      _socketClient.emit('tapGrid', {'index': index, 'roomID': roomID});
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

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (room) {
      Provider.of<RoomDataProvider>(context, listen: false).updateRoom(room);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      if (data['index'] != null && data['symbol'] != null) {
        RoomDataProvider roomDataProvider =
            Provider.of<RoomDataProvider>(context, listen: false);
        roomDataProvider.updateXO(data['index'], data['symbol']);
        roomDataProvider.updateRoom(data['room']);
      } else {
        print('Received null for index or symbol');
      }
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
