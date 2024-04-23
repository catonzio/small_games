import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/grid_widget.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/show_numbers_checkbox.dart';

class BodyGrid extends StatelessWidget {
  const BodyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final double dimension =
        Size(context.width * 0.6, context.height * 0.6).shortestSide;
    final EightPuzzleController controller = EightPuzzleController.to;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => controller.focusNode.requestFocus(),
              child: SizedBox(
                // height: dimension,
                width: dimension,
                child: Column(
                  children: [
                    AspectRatio(
                        aspectRatio: 1,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF050D1A), width: 3),
                              ),
                              child: Obx(() {
                                if (controller.isLoadingImage ||
                                    controller.grid.isSolved) {
                                  return Image.asset(
                                      key: UniqueKey(), controller.imagePath);
                                }
                                return Focus(
                                  focusNode: controller.focusNode,
                                  onKeyEvent: controller.onMove,
                                  child: GridWidget(
                                    dimension: dimension,
                                  ),
                                );
                              })),
                        )),
                    const ShowNumbersCheckbox(),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: context.height * 0.15,
            child: Align(
                alignment: Alignment.topLeft,
                child: ConfettiWidget(
                  confettiController: controller.confettiController,
                  // blastDirectionality: BlastDirectionality.directional,
                  blastDirection: -3.14 * (1 / 4.5),
                  emissionFrequency: 0.5,
                  numberOfParticles: 20,
                  gravity: 0.1,
                )),
          ),
          Positioned.fill(
            top: context.height * 0.15,
            child: Align(
                alignment: Alignment.topRight,
                child: ConfettiWidget(
                  confettiController: controller.confettiController,
                  // blastDirectionality: BlastDirectionality.directional,
                  blastDirection: 3.14 * (1 + 1 / 4.5),
                  gravity: 0.1,
                  emissionFrequency: 0.5,
                  numberOfParticles: 20,
                )),
          )
        ],
      ),
    );
  }
}
