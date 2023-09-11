import 'package:eight_puzzle/controllers/home_controller.dart';
import 'package:eight_puzzle/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoveArrow extends StatelessWidget {
  final int index;
  late String direction;
  late Icon icon;

  MoveArrow({super.key, required this.index}) {
    switch (index) {
      case 1:
        direction = "up";
        icon = const Icon(Icons.keyboard_arrow_up);
        break;
      case 3:
        direction = "left";
        icon = const Icon(Icons.keyboard_arrow_left);
        break;
      case 4:
        direction = "down";
        icon = const Icon(Icons.keyboard_arrow_down);
        break;
      case 5:
        direction = "right";
        icon = const Icon(Icons.keyboard_arrow_right);
        break;
      default:
        direction = "";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return direction.isEmpty
        ? Container()
        : Container(
            // margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: getColorScheme(context).surface,
            ),
            alignment: Alignment.center,
            child: IconButton(
              icon: icon,
              onPressed: () => Get.find<HomeController>().move(direction),
              iconSize:
                  (screenWidth(context, 10) + screenHeight(context, 5)) / 2,
              color: getColorScheme(context).primary,
              padding: EdgeInsets.zero,
            ),
          );
    ;
  }
}
