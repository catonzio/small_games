import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';

class ShowNumbersCheckbox extends StatelessWidget {
  const ShowNumbersCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;
    return Row(
      children: [
        Obx(() => Checkbox(
              value: controller.showNumbers,
              onChanged: (value) => controller.showNumbers = value ?? false,
            )),
        const Text("Show numbers"),
      ],
    );
  }
}
