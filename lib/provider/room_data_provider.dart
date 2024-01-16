import 'package:app_juegos/models/player.dart';
import 'package:flutter/material.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  Player _player1 = Player(username: "", socketID: "", score: 0.0, symbol: "X");
  Player _player2 = Player(username: "", socketID: "", score: 0.0, symbol: "O");

  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoom(Map<String, dynamic> roomData) {
    // _roomData.addAll(roomData);
    _roomData = roomData;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }
}
