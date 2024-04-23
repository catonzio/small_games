import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/shared/widgets/app_button.dart';

class LowerButtons extends StatelessWidget {
  const LowerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppButton(
          onPressed: controller.onShuffle,
          text: 'Shuffle',
          fullWidth: context.width * 0.2,
        ),
        AppButton(
          onPressed: controller.onSolve,
          text: 'Solve',
          fullWidth: context.width * 0.2,
        ),
      ],
    );
  }
}
