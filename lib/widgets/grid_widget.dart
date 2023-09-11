import 'dart:ui';

import 'package:eight_puzzle/controllers/home_controller.dart';
import 'package:eight_puzzle/widgets/grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridWidget extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final Size size;
  GridWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    Widget grid = GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: size.height / 3,
            crossAxisSpacing: 8),
        itemBuilder: (context, index) {
          return Obx(() => MGridTile(
                index: index,
                cellValue: homeController.game.grid[index].toString(),
              ));
        });
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Obx(() {
        print("Building grid: ${homeController.isSolving}");
        double sigmaX = homeController.isSolving ? 5 : 0;
        double sigmaY = homeController.isSolving ? 5 : 0;
        return Stack(children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: grid,
          ),
          if (homeController.isSolving)
            Center(
              child: SizedBox(
                  width: size.width / 3,
                  height: size.width / 3,
                  child: const CircularProgressIndicator(strokeWidth: 10)),
            )
        ]);
      }),
    );
  }
}
