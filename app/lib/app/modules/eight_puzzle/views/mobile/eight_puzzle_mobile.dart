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

class EightPuzzleMobile extends StatelessWidget {
  const EightPuzzleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomHeight = min(context.height * 0.2, 100);
    final double centralHeight = min(context.height * 0.6, 500);
    final double upperHeight = min(context.height * 0.2, 50);
    return SizedBox(
      height: context.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: upperHeight, child: _upperWidget()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _centralWidget(centralHeight),
          ),
          Container(
              color: AppColors.darkBackground,
              height: bottomHeight,
              child: _bottomWidget(bottomHeight)),
        ],
      ),
    );
  }

  Widget _bottomWidget(double imageSize) {
    return Container(
      height: imageSize / 1.2,
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: Constants.imagesList
            .map((e) => ImagePreview(
                  imagePath: e,
                  imageSize: imageSize / 1.2,
                ))
            .toList(),
      ),
    );
  }

  Widget _centralWidget(double centralWidth) {
    return SizedBox(
      width: centralWidth,
      // height: centralWidth,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [UpperButtons(), BodyGrid(), LowerButtons()],
      ),
    );
  }

  Widget _upperWidget() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GridSizeRadio(value: 9),
        GridSizeRadio(value: 16),
        // GridSizeRadio(value: 25),
      ],
    );
  }
}
