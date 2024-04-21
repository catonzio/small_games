import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;
  final bool isLast;
  final double cellSize;

  const CellWidget(
      {super.key,
      required this.cell,
      required this.cellSize,
      this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;

    return Obx(() => AnimatedPositioned(
          duration: controller.animationController.duration!,
          curve: Curves.linear,
          left: cell.col * cellSize,
          top: cell.row * cellSize,
          width: cellSize,
          height: cellSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (!isLast) ...[
                cell.image,
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF050D1A), width: 0),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
              Center(
                child: Text(
                  isLast ? "" : "${cell.value}",
                  style: context.textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ));
  }
}
