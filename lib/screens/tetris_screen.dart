import 'dart:async';
import 'dart:math';

import 'package:app_juegos/constants/piece_type.dart';
import 'package:app_juegos/widgets/blocks_grid.dart';
import 'package:app_juegos/widgets/tetris_piece.dart';
import 'package:flutter/material.dart';

// Entonces, en resumen, este código está creando una lista bidimensional de TetriPiece?
//de tamaño colLength x rowLength, donde cada elemento es inicialmente null. Esto podría representar, por ejemplo,
//un tablero de juego para un juego de Tetris, donde null representa un espacio vacío.
// This will help us to keep track of the landing pieces
List<List<TetriPiece?>> tablero =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class TetrisScreen extends StatefulWidget {
  const TetrisScreen({super.key});

  @override
  State<TetrisScreen> createState() => _TetrisScreenState();
}

class _TetrisScreenState extends State<TetrisScreen> {
  // Este es el primer bloque que se dibuja en la parte superior de la pantalla
  Piece currentPiece = Piece(type: TetriPiece.L);
  Random random = Random();
  bool gestureProcessed = false;
  bool rotateProcessed = false;
  bool gestureInProgress = false;
  int score = 0;

  void startGame() {
    //inicializar la pieza.
    currentPiece.initializaPiece();

    // start the timer -- frame loop
    Duration frameRate = const Duration(milliseconds: 400); // Speed of the game
    gameLoop(frameRate);
  }

  // Checar collicion
  bool checkCollision(Direction direction) {
    // check if the piece is at the last row
    for (int i = 0; i < currentPiece.position.length; i++) {
      // Esto es para calcular la row y la col de la pieza
      int row = (currentPiece.position[i] / rowLength)
          .floor(); // ~/ es para redondear hacia abajo
      int col = currentPiece.position[i] % rowLength;

      // Ajustar la posicion de la pieza
      if (direction == Direction.left) {
        col--;
      } else if (direction == Direction.right) {
        col++;
      } else if (direction == Direction.down) {
        row++;
      }

      if (row < 0 ||
          row >= colLength ||
          col < 0 ||
          col >= rowLength ||
          tablero[row][col] != null) {
        return true;
      }
    }

    return false;
  }

  void checkFloor() {
    // este metodo es para que la nueva piesa se marque como piso. MArcaremos las casillas que ocupa como ocupadas.
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength)
            .floor(); // ~/ es para redondear hacia abajo
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          tablero[row][col] = currentPiece.type;
        }
      }
      // Una vez que cae la pieza, crearemos otra.
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a new random piece
    currentPiece = Piece(
        type: TetriPiece.values[random.nextInt(TetriPiece.values.length)]);

    // initialize the piece
    currentPiece.initializaPiece();
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      // update the state of the game
      setState(() {

        // clear the line
        clearLine();
        // check for landing
        checkFloor();
        // move the piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotation();
    });
  }

  void clearLine(){
    // check if the line is full
    for(int i = 0; i < colLength; i++){
      bool isFull = true;
      for(int j = 0; j < rowLength; j++){
        if(tablero[i][j] == null){
          isFull = false;
          break;
        }
      }
      if(isFull){
        // clear the line
        for(int k = i; k > 0; k--){
          for(int l = 0; l < rowLength; l++){
            tablero[k][l] = tablero[k-1][l];
            score++;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (gestureProcessed || gestureInProgress) return;
                gestureInProgress = true;

                if (details.delta.dx > 0) {
                  // move right
                  if (!checkCollision(Direction.right)) {
                    setState(() {
                      currentPiece.movePiece(Direction.right);
                      gestureProcessed = true;
                    });
                  }
                } else {
                  // move left
                  if (!checkCollision(Direction.left)) {
                    setState(() {
                      currentPiece.movePiece(Direction.left);
                      gestureProcessed = true;
                    });
                  }
                }
              },
              onHorizontalDragEnd: (details) {
                gestureProcessed = false;
                gestureInProgress = false;
              },
              onVerticalDragUpdate: (details) {
                if (gestureInProgress) return;
                gestureInProgress = true;

                if (details.delta.dy > 0) {
                  // Mover la pieza hacia abajo hasta que colisione
                  while (!checkCollision(Direction.down)) {
                    setState(() {
                      currentPiece.movePiece(Direction.down);
                    });
                  }
                } else {
                  // Rotar la pieza solo una vez por gesto
                  if (!rotateProcessed) {
                    rotatePiece();
                    rotateProcessed = true;
                  }
                }
              },
              onVerticalDragEnd: (details) {
                rotateProcessed = false;
                gestureInProgress = false;
              },
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rowLength * colLength,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: ((context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  //current piece
                  if (currentPiece.position.contains(index)) {
                    return BlocksGrid(color: currentPiece.color);
                  } else if (tablero[row][col] != null) {
                    // landed pieces
                    final TetriPiece? type = tablero[row][col];
                    return BlocksGrid(color: tetriPieceColor[type]);
                  } else {
                    // blank spaces
                    return const BlocksGrid(
                        color: Color.fromRGBO(33, 33, 33, 1));
                  }
                }),
              ),
            ),
          ),
          TextButton(
              onPressed: startGame,
              child: const Text(
                "Start",
                style: TextStyle(color: Colors.white70),
              ))
        ],
      ),
    );
  }
}
