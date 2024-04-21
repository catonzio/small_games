import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/cell_widget.dart';

class GridWidget extends StatelessWidget {
  final double dimension;
  const GridWidget({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;
    final double cellSize = dimension / controller.cellsInRow;
    return Stack(children: [
      Opacity(
        opacity: 0.2,
        child: Image.asset(controller.imagePath),
      ),
      Opacity(
        opacity: 0.4,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF050D1A), width: 0),
            color: Colors.black,
          ),
        ),
      ),
      ...controller.subImages.map((Cell cell) => CellWidget(
            cell: cell,
            cellSize: cellSize,
            isLast: cell.value == controller.gridSize,
          ))
    ]);
  }
}
