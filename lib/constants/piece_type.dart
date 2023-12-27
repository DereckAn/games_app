import 'package:flutter/material.dart';

const int rowLength = 11;
const int colLength = 20;

enum TetriPiece {
  I,
  J,
  L,
  O,
  S,
  T,
  Z,
}

enum Direction { left, right, down, up }

const Map<TetriPiece, Color> tetriPieceColor = {
  TetriPiece.I: Colors.cyan,
  TetriPiece.J: Colors.blue,
  TetriPiece.L: Colors.orange,
  TetriPiece.O: Colors.yellow,
  TetriPiece.S: Colors.green,
  TetriPiece.T: Colors.purple,
  TetriPiece.Z: Colors.red,
};
