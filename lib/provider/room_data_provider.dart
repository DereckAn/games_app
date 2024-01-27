import 'package:app_juegos/models/player.dart';
import 'package:flutter/material.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _elements = ['', '', '', '', '', '', '', '', ''];
  // List<String> _elements = List<String>.generate(9, (index) => ''); // otra forma de hacerlo
  int _filledboxs = 0;

  Player _player1 = Player(username: "", socketID: "", score: 0.0, symbol: "X");
  Player _player2 = Player(username: "", socketID: "", score: 0.0, symbol: "O");

  Map<String, dynamic> get roomData => _roomData;
  List<String> get elements => _elements;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoom(Map<String, dynamic> roomData) {
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

  void updateXO(int index, String symbol){
    _elements[index] = symbol;
    _filledboxs++;
    notifyListeners();
  }
}
