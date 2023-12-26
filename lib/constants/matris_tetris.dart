import 'package:app_juegos/constants/piece_type.dart';

List<TetriPiece?> tablero = List.generate(colLength * rowLength, (i) => null);

// Para acceder a un elemento hay que calcular el índice manualmente:
TetriPiece? getPiece(int col, int row) {
  return tablero[col * rowLength + row];
}

// Para establecer un elemento, también se tiene que calcular el índice:
void setPiece(int col, int row, TetriPiece piece) {
  tablero[col * rowLength + row] = piece;
}