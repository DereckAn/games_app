import 'package:app_juegos/provider/room_data_provider.dart';
import 'package:app_juegos/resources/socket_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethod _socketMethod = SocketMethod();
  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethod.taGrid(
        index, roomDataProvider.roomData['_id'], roomDataProvider.elements);
  }

  @override
  void initState() {
    super.initState();
    _socketMethod.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => tapped(index, roomDataProvider),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  roomDataProvider.elements[index],
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: roomDataProvider.elements[index] == "O"
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          blurRadius: 40,
                          offset: const Offset(0, 0),
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
