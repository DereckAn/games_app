import 'package:app_juegos/constants/piece_type.dart';

class Piece {
  TetriPiece type;

  Piece({required this.type});

  List<List<int>> getPiece() {
    switch (type) {
      case TetriPiece.I:
        return [
          [1, 1, 1, 1]
        ];
      case TetriPiece.J:
        return [
          [1, 0, 0],
          [1, 1, 1]
        ];
      case TetriPiece.L:
        return [
          [0, 0, 1],
          [1, 1, 1]
        ];
      case TetriPiece.O:
        return [
          [1, 1],
          [1, 1]
        ];
      case TetriPiece.S:
        return [
          [0, 1, 1],
          [1, 1, 0]
        ];
      case TetriPiece.T:
        return [
          [0, 1, 0],
          [1, 1, 1]
        ];
      case TetriPiece.Z:
        return [
          [1, 1, 0],
          [0, 1, 1]
        ];
    }
  }
}
