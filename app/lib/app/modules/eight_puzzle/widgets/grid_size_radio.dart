import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';

class GridSizeRadio extends StatelessWidget {
  final int value;
  const GridSizeRadio({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;
    final int numsInRow = sqrt(value).toInt();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('$numsInRow x $numsInRow ($value)'),
        Obx(() => Radio(
            value: value,
            groupValue: controller.grid.gridSize,
            onChanged: (_) {
              if (!controller.isShowingSolvingMoves &&
                  !controller.isLoadingImage &&
                  !controller.isSolving) {
                controller.setImgsInRowFromGridSize(value);
              }
            }))
      ],
    );
  }
}
