import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/tic_tac_toe/controllers/tic_tac_toe_controller.dart';
import 'package:small_games/app/modules/tic_tac_toe/views/widgets/cell_widget.dart';
import 'package:small_games/config/app_colors.dart';

class GridWidget extends StatelessWidget {
  final double dimension;

  const GridWidget({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    final TicTacToeController controller = TicTacToeController.to;
    final double cellSize = dimension / 3;

    return SizedBox(
      width: dimension,
      height: dimension,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkBackground, width: 3),
            color: AppColors.appBarBackground,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: 9,
                    itemBuilder: (context, index) => CellWidget(index: index)),
              ),
              Obx(() => controller.gridController.winPositions.isNotEmpty
                  ? WinnerBar(
                      winPositions: controller.gridController.winPositions,
                      cellSize: cellSize,
                    )
                  : const SizedBox.shrink())
            ],
          ),
        ),
      ),
    );
  }
}

class WinnerBar extends StatelessWidget {
  final List<int> winPositions;
  final double cellSize;

  const WinnerBar(
      {super.key, required this.winPositions, required this.cellSize});

  @override
  Widget build(BuildContext context) {
    final double angle = _getAngleFromPositions();

    final bool isVertical = angle == pi / 2;
    final bool isDiagonal = angle.abs() == (pi / 4);

    return Transform.scale(
      scale: (isDiagonal ? sqrt(2) : 1) * 0.9,
      child: Transform.rotate(
        angle: angle,
        child: Align(
          alignment: _getAlignmentFromPositions(isDiagonal, isVertical),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            height: 3,
          ),
        ),
      ),
    );
  }

  Alignment _getAlignmentFromPositions(bool isDiagonal, bool isVertical) {
    double row = (winPositions[0] ~/ 3).toDouble();
    double col = (winPositions[0] % 3).toDouble();

    final Alignment verticalAlignment =
        Alignment(0, (1 - col) + (col < 1 ? -0.25 : (col > 1 ? 0.25 : 0)));
    final Alignment horizontalAlignment =
        Alignment(0, (row - 1) + (row < 1 ? 0.25 : (row > 1 ? -0.25 : 0)));
    const Alignment diagonalAlignment = Alignment(0, 0);

    return isDiagonal
        ? diagonalAlignment
        : (isVertical ? verticalAlignment : horizontalAlignment);
  }

  double _getAngleFromPositions() {
    double angle = 0;
    if (winPositions[1] - winPositions[0] == 4 &&
        winPositions[2] - winPositions[1] == 4) {
      angle = pi / 4;
    } else if (winPositions[1] - winPositions[0] == 2 &&
        winPositions[2] - winPositions[1] == 2) {
      angle = -pi / 4;
    } else if (winPositions[1] - winPositions[0] == 3 &&
        winPositions[2] - winPositions[1] == 3) {
      angle = pi / 2;
    }
    return angle;
  }
}
