import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/pong/models/pong_bar.dart';

class PongBarWidget extends StatelessWidget {
  final double width;
  final double height;
  final PongBar bar;
  final bool isPlayer;

  const PongBarWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.bar,
      required this.isPlayer});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Positioned(
          left: isPlayer ? width / 2 : context.width * 0.5 - width / 2,
          top: bar.y - height / 2,
          width: width,
          height: height,
          child: Container(
            color: isPlayer ? Colors.green : Colors.white,
          ),
        ));
  }
}
