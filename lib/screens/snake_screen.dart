import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SnakeScreen extends StatefulWidget {
  const SnakeScreen({super.key});

  @override
  State<SnakeScreen> createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  final int squaresPerRow = 20;
  final int squaresPerCol = 40;

  final randomGen = Random();
  late Timer gameTimer;

  List<int> snakePosition = [45, 65, 85, 105, 125];
  int food = 300;
  String direction = 'down';
  bool isGamePaused = false;
  bool isGameStarted = false;

  void initializeGame() {
    snakePosition = [45, 65, 85, 105, 125];
    direction = 'down';
    food = randomGen.nextInt((squaresPerCol * squaresPerRow) - 1);
  }

  void startGame() {
    const duration = Duration(milliseconds: 200);

    gameTimer = Timer.periodic(duration, (Timer timer) {
      if (!isGamePaused) {
        updateSnake();
        if (gameOver()) {
          timer.cancel();
        }
      }
    });
    setState(() {
      isGameStarted = true;
    });
  }

  void pauseGame() {
    setState(() {
      isGamePaused = !isGamePaused;
      if (isGamePaused) {
        gameTimer.cancel();
      } else {
        startGame();
      }
    });
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > 760) {
            snakePosition.add(snakePosition.last + 20 - 800);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;
        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + 800);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;
        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;
        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;
        default:
      }

      if (snakePosition.last == food) {
        food = randomGen.nextInt(700);
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    return snakePosition.toSet().length != snakePosition.length;
    //En este código, snakePosition.toSet() convierte snakePosition a un Set, que es una colección de elementos únicos. Si la longitud del
    //Set es diferente a la longitud de snakePosition, eso significa que hay duplicados en snakePosition,
    //por lo que la serpiente se ha chocado consigo misma y el juego ha terminado.
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.secondary);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  // delta.dy > 0 means that the user is swiping down y ponen el != 'up' para que no se coma a si misma
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  // delta.dy < 0 means that the user is swiping up
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  // delta.dx > 0 means that the user is swiping right y ponen el != 'left' para que no se coma a si misma si va en la direccion izquierda actualmente
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  // delta.dx < 0 means that the user is swiping left y ponen el != 'right' para que no se coma a si misma si va en la direccion derecha actualmente
                  direction = 'left';
                }
              },
              child: AspectRatio(
                aspectRatio: squaresPerRow / (squaresPerCol + 5),
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), //Esto se usa para deshabilitar el desplazamiento en la cuadrícula.
                  itemCount: squaresPerRow * squaresPerCol,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: squaresPerRow,
                    //Esto se usa para controlar el diseño de los elementos de la cuadrícula. Aquí, se establece que cada fila tendrá squaresPerRow = 20 cuadrados.
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (snakePosition.contains(index)) {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(color: Colors.green),
                        ),
                      );
                    } else if (index == food) {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(color: Colors.red),
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(color: Colors.grey[900]),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isGameStarted
                    ? GestureDetector(
                        onTap: pauseGame,
                        child: Text(isGamePaused ? "Resume" : "Pause",
                            style: textStyle),
                      )
                    : GestureDetector(
                        onTap: startGame,
                        child: Text("START", style: textStyle),
                      ),
                Text("Score: ${snakePosition.length}", style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
