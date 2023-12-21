import 'package:flutter/material.dart';

class BlocksSnake extends StatelessWidget {
  const BlocksSnake({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(color:color),
      ),
    );
  }
}
