import 'dart:async';
import 'dart:math';

import 'package:app_juegos/widgets/blocks_grid.dart';
import 'package:app_juegos/widgets/game_over_dialog.dart';
import 'package:flutter/material.dart';

class SnakeScreen extends StatefulWidget {
  const SnakeScreen({super.key});

  @override
  State<SnakeScreen> createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  final int squaresPerRow = 25;
  final int squaresPerCol = 50;
  final int initialSnakeSize = 5;
  final int initialSnakePosition = 45;
  final randomGen = Random();

  late int normalFruitsEaten = snakePosition.length - initialSnakeSize;
  late Timer gameTimer;
  late int otroLado = (squaresPerRow * squaresPerCol);
  late List<int> snakePosition = List<int>.generate(
      initialSnakeSize, (i) => initialSnakePosition + (squaresPerRow * i));

  int food = 855;
  int poisonFood = -1;
  int goldenApple = -1;
  int goldenAppleMoves = 0;
  String direction = 'down';
  bool isGamePaused = false;
  bool isGameStarted = false;

  void initializeGame() {
    snakePosition = List<int>.generate(
        initialSnakeSize,
        (index) =>
            initialSnakePosition +
            (squaresPerRow *
                index)); // & Esto es un for loop para decir lo mismo que SnakePosition en la linea 20
    direction = 'down';
    food = randomGen.nextInt(otroLado - 1);
  }

  void startGame() {
    const duration = Duration(milliseconds: 200);

    gameTimer = Timer.periodic(duration, (Timer timer) {
      if (!isGamePaused) {
        updateSnake();
        if (checkGameOver()) {
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

  int generateNewPosition() {
    int newPosition = randomGen.nextInt(otroLado - 1);
    while (snakePosition.contains(newPosition)) {
      newPosition = randomGen.nextInt(otroLado - 1);
    }
    return newPosition;
  }

  void generatePoisonFood() {
    setState(() {
      poisonFood = generateNewPosition();
    });
  }

  void generateGoldenApple() {
    setState(() {
      goldenApple = generateNewPosition();
      goldenAppleMoves =
          0; // Reinicia el contador de movimientos cuando generas una nueva manzana dorada
    });
  }

  void generateNewFood() {
    food = generateNewPosition();
  }

  void updateSnake() {
    normalFruitsEaten = snakePosition.length - initialSnakeSize;
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > otroLado - squaresPerRow) {
            snakePosition.add(snakePosition.last + squaresPerRow - otroLado);
          } else {
            snakePosition.add(snakePosition.last + squaresPerRow);
          }
          break;
        case 'up':
          if (snakePosition.last < squaresPerRow) {
            snakePosition.add(snakePosition.last - squaresPerRow + otroLado);
          } else {
            snakePosition.add(snakePosition.last - squaresPerRow);
          }
          break;
        case 'left':
          if (snakePosition.last % squaresPerRow == 0) {
            snakePosition.add(snakePosition.last - 1 + squaresPerRow);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;
        case 'right':
          if ((snakePosition.last + 1) % squaresPerRow == 0) {
            snakePosition.add(snakePosition.last + 1 - squaresPerRow);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;
        default:
      }

      if (snakePosition.last == food) {
        generateNewFood();
        if (normalFruitsEaten % 3 == 0) {
          generatePoisonFood();
        }
        if (normalFruitsEaten % 7 == 0) {
          generateGoldenApple();
        }
      } else if (snakePosition.last == poisonFood) {
        endGame();
      } else if (snakePosition.last == goldenApple) {
        int valueToAdd = 0;
        if (direction == 'down') {
          valueToAdd = squaresPerRow;
        } else if (direction == 'up') {
          valueToAdd = -squaresPerRow;
        } else if (direction == 'left') {
          valueToAdd = -1;
        } else if (direction == 'right') {
          valueToAdd = 1;
        }

        for (int i = 0; i < 5; i++) {
          snakePosition.add(snakePosition.last + valueToAdd);
        }

        goldenApple = -1;
      } else {
        snakePosition.removeAt(0);
        // Si se han comido 2 frutas normales después de la fruta envenenada, la elimina
        if (poisonFood != -1 && normalFruitsEaten % 3 == 0) {
          poisonFood = -1;
        }
        // Elimina la manzana dorada después de un cierto número de movimientos o tiempo
        if (goldenApple != -1 && goldenAppleMoves >= 30) {
          // Cambia 10 al número de movimientos que quieras que la manzana dorada esté presente
          goldenApple = -1;
        }
      }
      if (goldenApple != -1) {
        goldenAppleMoves++; // Incrementa el contador de movimientos si la manzana dorada está presente
      }
    });
  }

  bool checkGameOver() {
    if (snakePosition.toSet().length != snakePosition.length) {
      endGame();
      return true;
    }
    return false;
  }

  void endGame() {
    if (gameTimer.isActive) {
      gameTimer.cancel();
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameOverDialog(
          initializeGame: initializeGame,
          points: normalFruitsEaten,
          startGame: startGame,
        );
      },
    );
  }

  // bool gameOver() {
  //   return snakePosition.toSet().length != snakePosition.length;
  //En este código, snakePosition.toSet() convierte snakePosition a un Set, que es una colección de elementos únicos. Si la longitud del
  //Set es diferente a la longitud de snakePosition, eso significa que hay duplicados en snakePosition,
  //por lo que la serpiente se ha chocado consigo misma y el juego ha terminado.
  // }

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
                aspectRatio: squaresPerRow / (squaresPerCol + 3),
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), //Esto se usa para deshabilitar el desplazamiento en la cuadrícula.
                  itemCount: otroLado,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: squaresPerRow,
                    //Esto se usa para controlar el diseño de los elementos de la cuadrícula. Aquí, se establece que cada fila tendrá squaresPerRow = 20 cuadrados.
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (snakePosition.contains(index)) {
                      return const BlocksGrid(
                        color: Colors.green,
                      );
                    } else if (index == food) {
                      return const BlocksGrid(
                        color: Colors.red,
                      );
                    } else if (index == poisonFood) {
                      return const BlocksGrid(
                        color: Colors.purple,
                      );
                    } else if (index == goldenApple) {
                      return const BlocksGrid(
                        color: Color.fromARGB(255, 132, 120, 8),
                      );
                    } else {
                      return const BlocksGrid(color: Color(0xFF1D1D1D));
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 5.0, left: 20.0, right: 20.0),
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
                isGameStarted
                    ? GestureDetector(
                        onTap: endGame,
                        child: Text("Die", style: textStyle),
                      )
                    : GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text("Exit", style: textStyle),
                      ),
                Text("Apples: $normalFruitsEaten", style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
