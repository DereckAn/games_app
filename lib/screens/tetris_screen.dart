import 'package:app_juegos/widgets/blocks_grid.dart';
import 'package:flutter/material.dart';

class TetrisScreen extends StatefulWidget {
  const TetrisScreen({super.key});

  @override
  State<TetrisScreen> createState() => _TetrisScreenState();
}

class _TetrisScreenState extends State<TetrisScreen> {
  int rowLength = 10;
  int colLength = 19;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0), // here the desired height
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title:  const Text(
            'Tetris',
            style:  TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rowLength * colLength,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rowLength),
        itemBuilder: ((context, index) => const Center(
              child: BlocksGrid(
                color: Color(0xFF1D1D1D),
              ),
            )),
      ),
    );
  }
}
