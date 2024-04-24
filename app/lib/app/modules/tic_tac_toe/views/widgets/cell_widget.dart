import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/tic_tac_toe/controllers/tic_tac_toe_controller.dart';
import 'package:small_games/config/app_colors.dart';

class CellWidget extends StatelessWidget {
  final int index;

  const CellWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final TicTacToeController controller = TicTacToeController.to;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.darkBackground, width: 0),
      ),
      child: Obx(
        () {
          String char = controller.gridController.grid[index];
          return InkWell(
            onTap: controller.gridController.grid[index].isEmpty
                ? () => controller.onPlay(index)
                : null,
            child: Center(
              child: Text(
                char,
                style: TextStyle(
                    fontSize: 32,
                    color: char == 'X' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
