import 'package:app_juegos/provider/room_data_provider.dart';
import 'package:app_juegos/resources/socket_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;

  void createGame(String username) {
    if(username.isNotEmpty){
      _socketClient.emit('createGame', {'username': username});
    }
  }

  void createGameSuccessListener(BuildContext context) {
    _socketClient.on('createdGameSuccess', (room) {
      Navigator.pushNamed(context, '/playingTTT', arguments: room);
      print(room);
      Provider.of<RoomDataProvider>(context, listen: false).updateRoom(room);
    });
  }
}