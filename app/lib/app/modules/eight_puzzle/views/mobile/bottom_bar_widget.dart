import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/image_preview.dart';
import 'package:small_games/config/constants.dart';

class BottomBarWidget extends StatelessWidget {
  final double imageSize;

  const BottomBarWidget({
    super.key,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
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
}
