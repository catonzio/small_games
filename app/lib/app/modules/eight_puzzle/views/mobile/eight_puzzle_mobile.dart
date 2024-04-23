import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/views/mobile/bottom_bar_widget.dart';
import 'package:small_games/app/modules/eight_puzzle/views/mobile/top_bar_widget.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/body_grid.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/lower_buttons.dart';
import 'package:small_games/config/app_colors.dart';

class EightPuzzleMobile extends StatelessWidget {
  const EightPuzzleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double upperHeight = min(context.height * 0.25, 500);
    final double centralHeight = min(context.height * 0.5, 500);
    final double bottomHeight = min(context.height * 0.25, 100);

    return SizedBox(
      height: context.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: upperHeight,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TopBarWidget(),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _centralWidget(centralHeight),
          ),
          Container(
              color: AppColors.darkBackground,
              height: bottomHeight,
              child: BottomBarWidget(
                imageSize: bottomHeight,
              )),
        ],
      ),
    );
  }

  Widget _centralWidget(double centralWidth) {
    return SizedBox(
      width: centralWidth,
      // height: centralWidth,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [BodyGrid(), LowerButtons()],
      ),
    );
  }
}
