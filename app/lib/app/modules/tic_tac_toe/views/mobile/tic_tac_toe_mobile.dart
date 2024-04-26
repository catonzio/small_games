import 'package:flutter/material.dart';
import 'package:small_games/app/modules/tic_tac_toe/controllers/tic_tac_toe_controller.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/tic_tac_toe/views/widgets/grid_widget.dart';

class TicTacToeMobile extends StatelessWidget {
  const TicTacToeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final TicTacToeController controller = TicTacToeController.to;
    final double dimension =
        Size(context.width * 0.5, context.height * 0.5).shortestSide;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Text(
                controller.gridController.winPositions.isNotEmpty
                    ? "Player ${controller.firstPlayerTurn ? 'X' : 'O'} wins!"
                    : (controller.gridController.currentPlaced.value == 9
                        ? "Draw!"
                        : "Player's turn: ${controller.firstPlayerTurn ? 'X' : 'O'}"),
                style: context.textTheme.headlineMedium,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => Text(
                  "Player's turn: ${controller.firstPlayerTurn ? 'X' : 'O'}",
                  style: context.textTheme.headlineMedium,
                )),
          ),
          IconButton(
              onPressed: controller.restartGame,
              icon: const Icon(Icons.refresh)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridWidget(
              dimension: dimension,
            ),
          ),
        ],
      ),
    );
  }
}
