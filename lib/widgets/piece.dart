// import 'package:app_juegos/constants/piece_type.dart';

// class Piece {
//   final TetriPiece type;
//   final List<List<int>> shape;
//   final List<int> xy;
//   final int rotateIndex;

//   Piece(this.type, this.shape, this.xy, this.rotateIndex);

//   Piece fall({int step = 1}) {
//     return Piece(type, shape, [xy[0], xy[1] + step], rotateIndex);
//   }

//   Piece right() {
//     return Piece(type, shape, [xy[0] + 1, xy[1]], rotateIndex);
//   }

//   Piece left() {
//     return Piece(type, shape, [xy[0] - 1, xy[1]], rotateIndex);
//   }

//   Piece rotate() {
//     List<List<int>> result =
//         List.filled(shape[0].length, const [], growable: false);
//     for (int row = 0; row < shape.length; row++) {
//       for (int col = 0; col < shape[row].length; col++) {
//         if (result[col].isEmpty) {
//           result[col] = List.filled(shape.length, 0, growable: false);
//         }
//         result[col][row] = shape[shape.length - 1 - row][col];
//       }
//     }
//     final nextXy = [
//       xy[0] + ORIGIN[type]![rotateIndex][0],
//       xy[1] + ORIGIN[type]![rotateIndex][1]
//     ];
//     final nextRotateIndex =
//         rotateIndex + 1 >= ORIGIN[type]!.length ? 0 : rotateIndex + 1;

//     return Piece(type, result, nextXy, nextRotateIndex);
//   }

//   bool isValidInMatrix(List<List<int>> matrix) {
//     if (xy[1] + shape.length > colLength ||
//         xy[0] < 0 ||
//         xy[0] + shape[0].length > rowLength) {
//       return false;
//     }
//     for (var i = 0; i < matrix.length; i++) {
//       final line = matrix[i];
//       for (var j = 0; j < line.length; j++) {
//         if (line[j] == 1 && get(j, i) == 1) {
//           return false;
//         }
//       }
//     }
//     return true;
//   }

//   int? get(int x, int y) {
//     x -= xy[0];
//     y -= xy[1];
//     if (x < 0 || x >= shape[0].length || y < 0 || y >= shape.length) {
//       return null;
//     }
//     return shape[y][x] == 1 ? 1 : null;
//   }

//   static Piece fromType(TetriPiece type) {
//     final shape = BLOCK_SHAPES[type];
//     return Piece(type, shape!, START_XY[type]!, 0);
//   }

//   static Piece getRandom() {
//     final i = math.Random().nextInt(TetriPiece.values.length);
//     return fromType(TetriPiece.values[i]);
//   }
// }
