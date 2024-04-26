import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';

class SolverSpeedSlider extends StatelessWidget {
  const SolverSpeedSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;

    return Obx(() => Slider(
            value: controller.solvingSpeed,
            onChanged: (value) => controller.solvingSpeed = value,
            min: 50,
            max: 1000,
            divisions: 50,
            label: controller.solvingSpeed.round().toString())
        .animate(target: controller.isShowingSolvingMoves ? 1 : 0)
        .fade());
  }
}
