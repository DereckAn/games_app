import 'package:app_juegos/provider/room_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PointsBoard extends StatelessWidget {
  const PointsBoard({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Text(
                roomDataProvider.player1.username,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                roomDataProvider.player2.score.toString(),
                style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Text(
                roomDataProvider.player2.username,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                roomDataProvider.player2.score.toString(),
                style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
              )
            ],
          ),
        ),
      ],
    );
  }
}
