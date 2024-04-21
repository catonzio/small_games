import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/grid_widget.dart';

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
          height: dimension,
          width: dimension,
          child: AspectRatio(
              aspectRatio: 1,
              child: Obx(
                () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    // transitionBuilder: (child, animation) {
                    //   return ScaleTransition(
                    //     scale: animation,
                    //     child: child,
                    //   );
                    // },
                    child: controller.isLoadingImage || !controller.hasShuffled
                        ? Image.asset(
                            key: UniqueKey(),
                            controller
                                .imagePath) // const CircularProgressIndicator()
                        : Focus(
                            focusNode: controller.focusNode,
                            onKeyEvent: (node, event) {
                              Direction? direction = getDirectionFromKey(event);
                              if (direction != null) {
                                controller.move(direction);
                              }
                              return KeyEventResult.handled;
                            },
                            child: GridWidget(
                              dimension: dimension,
                            ),
                          )),
              )),
        ),
      ),
    );
  }
}

Direction? getDirectionFromKey(KeyEvent event) {
  if (event.runtimeType == KeyDownEvent) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.keyW) {
      return Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.keyS) {
      return Direction.down;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.keyA) {
      return Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.keyD) {
      return Direction.right;
    }
  }
  return null;
}

enum Direction {
  up,
  down,
  left,
  right,
}
