import 'package:app_juegos/constants/piece_type.dart';
import 'package:app_juegos/screens/tetris_screen.dart';
import 'package:flutter/material.dart';

class Piece {
  TetriPiece type;
  List<int> position = [];
  int rotationState = 1;

  Piece({required this.type});

  Color get color => tetriPieceColor[type] ?? Colors.white;

  void initializaPiece() {
    switch (type) {
      case TetriPiece.I:
        position = [-7, -6, -5, -4];
        break;
      case TetriPiece.J:
        position = [-18, -7, -6, -5];
        break;
      case TetriPiece.L:
        position = [-6, -5, -7, -16];
        break;
      case TetriPiece.O:
        position = [-17, -16, -6, -5];
        break;
      case TetriPiece.S:
        position = [-16, -17, -7, -6];
        break;
      case TetriPiece.T:
        position = [-17, -6, -7, -5];
        break;
      case TetriPiece.Z:
        position = [-18, -17, -6, -5];
        break;
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.left:
        position = position.map((e) => e - 1).toList();
        break;
      case Direction.right:
        position = position.map((e) => e + 1).toList();
        break;
      case Direction.down:
        position = position.map((e) => e + rowLength).toList();
        break;
      case Direction.up:
        position = position.map((e) => e - rowLength).toList();
        break;
    }
  }

  // rotate piece

  void rotation() {
    int pivot = position[1];

    if (type == TetriPiece.O) {
      return; // Skip rotation for O piece
    }

    Map<TetriPiece, List<List<int>>> rotationStates = {
      TetriPiece.I: [
        [pivot - rowLength, pivot, pivot + rowLength, pivot + (2 * rowLength)],
        [pivot - 1, pivot, pivot + 1, pivot + 2]
      ],
      TetriPiece.J: [
        [pivot + 1, pivot, pivot + rowLength, pivot + (rowLength * 2)],
        [pivot + rowLength, pivot, pivot - 1, pivot - 2],
        [pivot - 1, pivot, pivot - rowLength, pivot - (rowLength * 2)],
        [pivot - rowLength, pivot, pivot + 1, pivot + 2]
      ],
      TetriPiece.L: [
        [pivot + 1, pivot, pivot - rowLength, pivot - (rowLength * 2)],
        [pivot + rowLength, pivot, pivot + 1, pivot + 2],
        [pivot - 1, pivot, pivot + rowLength, pivot + (rowLength * 2) ],
        [pivot - rowLength, pivot, pivot - 1, pivot - 2],
      ],
      TetriPiece.O: [
        [pivot - 1, pivot, pivot - rowLength, pivot - rowLength - 1]
      ],
      TetriPiece.S: [
        [pivot - rowLength, pivot, pivot + 1, pivot + rowLength + 1],
        [pivot + 1, pivot, pivot + rowLength - 1, pivot + rowLength]
      ],
      TetriPiece.T: [
        [pivot - rowLength, pivot, pivot + 1, pivot + rowLength],
        [pivot - 1, pivot, pivot + 1, pivot + rowLength],
        [pivot - rowLength, pivot, pivot - 1, pivot + rowLength],
        [pivot - 1, pivot, pivot + 1, pivot - rowLength]
      ],
      TetriPiece.Z: [
        [pivot + rowLength, pivot, pivot + 1, pivot + 1 - rowLength],
        [pivot - 1, pivot, pivot + rowLength, pivot + rowLength + 1]
      ],
    };
    rotationState = (rotationState + 1) % rotationStates[type]!.length;

    position = rotationStates[type]![rotationState];
    // todo Arreglar que las piezas se pasen al otro lado de la pantalla

    // if (pieceValidPosition(rotationStates[type]![rotationState])) {
    // }
  }

  bool validRotation(int position) {
    int row = (position ~/ rowLength);
    int col = position % rowLength;
    if (row < 0 || col < 0 || tablero[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool pieceValidPosition(List<int> position) {
    bool colOc = false;
    bool lasOc = false;

    for (int i in position) {
      if (!validRotation(i)) {
        return false;
      }
      int col = i % rowLength;
      if (col == 0) {
        colOc = true;
      }
      if (col == rowLength - 1) {
        lasOc = true;
      }
    }
    return !(colOc && lasOc);
  }
}
