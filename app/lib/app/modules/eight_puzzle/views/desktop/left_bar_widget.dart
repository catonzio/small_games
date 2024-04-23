import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/image_preview.dart';
import 'package:small_games/config/constants.dart';

class LeftBarWidget extends StatelessWidget {
  final double imageSize;

  const LeftBarWidget({
    super.key,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
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
}