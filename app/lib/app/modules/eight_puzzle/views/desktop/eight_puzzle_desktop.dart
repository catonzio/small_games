import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/views/desktop/left_bar_widget.dart';
import 'package:small_games/app/modules/eight_puzzle/views/desktop/right_bar_widget.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/body_grid.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/lower_buttons.dart';
import 'package:small_games/config/app_colors.dart';

class EightPuzzleDesktop extends StatelessWidget {
  const EightPuzzleDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final double leftWidth = min(context.width, 150);
    final double centralWidth = min(context.width, 900);
    final double rightWidth = min(context.width, 150);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            color: AppColors.darkBackground,
            width: leftWidth,
            child: LeftBarWidget(
              imageSize: leftWidth,
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _centralWidget(centralWidth),
          ),
        ),
        SizedBox(width: rightWidth, child: const RightBarWidget()),
      ],
    );
  }

  Center _centralWidget(double centralWidth) {
    return Center(
      child: SizedBox(
        width: centralWidth,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BodyGrid(),
            LowerButtons(),
          ],
        ),
      ),
    );
  }
}
