import 'package:app_juegos/constants/piece_type.dart';

class Piece {
  TetriPiece type;
  List<int> position = [];

  Piece({required this.type});

  void initializaPiece() {
    switch (type) {
      case TetriPiece.I:
        position = [-39, -28, -17, -6];
        break;
      case TetriPiece.J:
        position = [-5, -6, -7, -18];
        break;
      case TetriPiece.L:
        position = [-7, -6, -5, -16];
        break;
      case TetriPiece.O:
        position = [-6, -5, -17, -16];
        break;
      case TetriPiece.S:
        position = [-7, -6, -17, -16];
        break;
      case TetriPiece.T:
        position = [-7, -6, -5, -17];
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
}
