import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/eight_puzzle_controller.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  const ImagePreview({super.key, required this.imagePath, required this.imageSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: imageSize,
        width: imageSize,
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
