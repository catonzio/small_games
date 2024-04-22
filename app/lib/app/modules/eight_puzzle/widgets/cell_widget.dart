import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;
  final bool isLast;
  final double cellSize;
  final Image image;

  const CellWidget(
      {super.key,
      required this.cell,
      required this.cellSize,
      required this.image,
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
                image,
                Opacity(
                  opacity: controller.showNumbers ? 0.25 : 0.1,
                  child: Container(
                      decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 0,
                    ),
                  )),
                ),
              ],
              AnimatedOpacity(
                duration: controller.animationController.duration!,
                opacity: controller.showNumbers ? 1 : 0,
                child: Center(
                  child: Text(
                    isLast ? "" : "${cell.value}",
                    style: context.textTheme.headlineLarge,
                  ),
                ),
              ).animate().rotate(begin: 0, end: 90),
            ],
          ),
        ));
  }
}
