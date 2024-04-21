import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/body_grid.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/lower_buttons.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/upper_buttons.dart';
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
            color: const Color(0xFF050D1A),
            width: leftWidth,
            child: _leftWidget()),
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

  Widget _leftWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: Constants.imagesList
            .map((e) => ImagePreview(
                  imagePath: e,
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
        GridSizeRadio(value: 25),
      ],
    );
  }
}

class GridSizeRadio extends StatelessWidget {
  final int value;
  const GridSizeRadio({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final EightPuzzleController controller = EightPuzzleController.to;
    final int numsInRow = sqrt(value).toInt();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('$numsInRow x $numsInRow ($value)'),
        Obx(() => Radio(
            value: value,
            groupValue: controller.grid.gridSize,
            onChanged: (_) {
              controller.setImgsInRowFromGridSize(value);
            }))
      ],
    );
  }
}

class ImagePreview extends StatelessWidget {
  final String imagePath;
  const ImagePreview({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: InkWell(
          onTap: () {
            EightPuzzleController.to.imagePath = imagePath;
          },
        ),
      ),
    );
  }
}
