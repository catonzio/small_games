import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/cell_widget.dart';

class GridWidget extends StatelessWidget {
  final double dimension;
  const GridWidget({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;
    final double cellSize = dimension / controller.grid.cellsInRow;

    return Stack(children: [
      Opacity(
        opacity: 0.3,
        child: SizedBox(
            width: dimension,
            height: dimension,
            child: Image.asset(controller.imagePath, fit: BoxFit.fill)),
      ),
      Opacity(
        opacity: 0.4,
        child: Container(
          color: Colors.black,
        ),
      ),
      ...controller.grid.cells.map((Cell cell) => CellWidget(
            cell: cell,
            cellSize: cellSize,
            image: controller.subImages[cell.value - 1],
            isLast: cell.value == controller.grid.gridSize,
          )),
      Obx(() => controller.isSolving
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const SizedBox.shrink())
    ]);
  }
}
