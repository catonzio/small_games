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
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: size.height / 3,
              crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Obx(() => MGridTile(
                  cellValue: homeController.grid[index].toString(),
                ));
          }),
    );
  }
}
