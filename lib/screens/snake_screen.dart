import 'dart:async';
import 'dart:math';

import 'package:app_juegos/widgets/blocks_snake.dart';
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

  late Timer poisonFoodTimer;
  late Timer gameTimer;
  late int otroLado = (squaresPerRow * squaresPerCol);
  late List<int> snakePosition = [
    initialSnakePosition,
    initialSnakePosition + (squaresPerRow * 1),
    initialSnakePosition + (squaresPerRow * 2),
    initialSnakePosition + (squaresPerRow * 3),
    initialSnakePosition + (squaresPerRow * 4)
  ];
  int food = 300;
  int poisonFood = -1;
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
    food = randomGen.nextInt((squaresPerCol * squaresPerRow) - 1);
    poisonFoodTimer.cancel();
    poisonFood = -1;
  }

  void startGame() {
    const duration = Duration(milliseconds: 200);

    gameTimer = Timer.periodic(duration, (Timer timer) {
      if (!isGamePaused) {
        updateSnake();
        if (gameOver()) {
          timer.cancel();

        }
      } else {
        poisonFoodTimer.cancel();
      }
    });
    setState(() {
      isGameStarted = true;
    });
    poisonFoodTimer =
        Timer.periodic(const Duration(seconds: 20), (Timer timer) {
      generatePoisonFood();
      Timer(const Duration(seconds: 10), () {
        setState(() {
          poisonFood = -1;
        });
      });
    });
  }

  void generatePoisonFood() {
    int newPoisonFoodPosition = randomGen.nextInt(otroLado - 1);
    while (snakePosition.contains(newPoisonFoodPosition)) {
      newPoisonFoodPosition = randomGen.nextInt(otroLado - 1);
    }
    setState(() {
      poisonFood = newPoisonFoodPosition;
    });
  }

  void pauseGame() {
    setState(() {
      isGamePaused = !isGamePaused;
      if (isGamePaused) {
        poisonFoodTimer.cancel();
        gameTimer.cancel();
      } else {
        startGame();
        poisonFoodTimer =
            Timer.periodic(const Duration(seconds: 20), (Timer timer) {
          generatePoisonFood();
          Timer(const Duration(seconds: 10), () {
            setState(() {
              poisonFood = -1;
            });
          });
        });
      }
    });
  }

  void generateNewFood() {
    int newFoodPosition = randomGen.nextInt(otroLado - 1);

    while (snakePosition.contains(newFoodPosition)) {
      newFoodPosition = randomGen.nextInt(otroLado - 1);
    }

    food = newFoodPosition;
  }

  void updateSnake() {
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
      } else if (snakePosition.last == poisonFood) {
        gameOver();
      } else {
        snakePosition.removeAt(0);
      }

    });
  }

  bool gameOver() {
    if (snakePosition.toSet().length != snakePosition.length) {
      // Si el juego ha terminado, muestra un AlertDialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text(
              'Game Over',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
                'Total Score: ${snakePosition.length - initialSnakeSize} \n Play Again?'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Yes',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  initializeGame();
                  startGame();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'No',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return true;
    }
    return false;
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
                  itemCount: squaresPerRow * squaresPerCol,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: squaresPerRow,
                    //Esto se usa para controlar el diseño de los elementos de la cuadrícula. Aquí, se establece que cada fila tendrá squaresPerRow = 20 cuadrados.
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (snakePosition.contains(index)) {
                      return const BlocksSnake(color: Colors.green,);
                    } else if (index == food) {
                      return const BlocksSnake(color: Colors.red,);
                    } else if (index == poisonFood) {
                      return const BlocksSnake(color: Colors.purple,);
                    } else {
                      return const BlocksSnake(color: Color(0xFF1D1D1D));
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
                Text("Apples: ${snakePosition.length - initialSnakeSize}",
                    style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
