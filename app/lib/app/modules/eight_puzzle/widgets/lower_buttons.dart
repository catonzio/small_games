import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';

class LowerButtons extends StatelessWidget {
  const LowerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: controller.shuffle, child: const Text('Shuffle')),
      ],
    );
  }
}
