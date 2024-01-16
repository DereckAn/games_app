import 'package:flutter/material.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  Map<String, dynamic> get roomData => _roomData;

  void updateRoom(Map<String, dynamic> roomData) {
    // _roomData.addAll(roomData);
    _roomData = roomData;
    notifyListeners();
  }
}
