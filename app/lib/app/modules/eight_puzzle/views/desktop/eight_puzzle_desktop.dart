import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/body_grid.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/grid_size_radio.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/image_preview.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/lower_buttons.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/upper_buttons.dart';
import 'package:small_games/config/app_colors.dart';
import 'package:small_games/config/constants.dart';

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
            child: _leftWidget(leftWidth)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _centralWidget(centralWidth),
          ),
        ),
        SizedBox(width: rightWidth, child: _rightWidget()),
      ],
    );
  }

  Widget _leftWidget(double imageSize) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: Constants.imagesList
            .map((e) => ImagePreview(
                  imagePath: e,
                  imageSize: imageSize / 1.2,
                ))
            .toList(),
      ),
    );
  }

  Center _centralWidget(double centralWidth) {
    return Center(
      child: SizedBox(
        width: centralWidth,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [UpperButtons(), BodyGrid(), LowerButtons()],
        ),
      ),
    );
  }

  Widget _rightWidget() {
    return const Column(
      children: [
        GridSizeRadio(value: 9),
        GridSizeRadio(value: 16),
        // GridSizeRadio(value: 25),
      ],
    );
  }
}
