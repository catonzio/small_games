import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/grid_widget.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/show_numbers_checkbox.dart';

class BodyGrid extends StatelessWidget {
  const BodyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final double dimension =
        Size(context.width * 0.7, context.height * 0.7).shortestSide;
    final EightPuzzleController controller = EightPuzzleController.to;
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                        child: Obx(
                          () => controller.isLoadingImage
                              ? Image.asset(
                                  key: UniqueKey(), controller.imagePath)
                              : Focus(
                                  focusNode: controller.focusNode,
                                  onKeyEvent: controller.onMove,
                                  child: GridWidget(
                                    dimension: dimension,
                                  ),
                                ),
                        )),
                  )),
              const ShowNumbersCheckbox(),
            ],
          ),
        ),
      ),
    );
  }
}
