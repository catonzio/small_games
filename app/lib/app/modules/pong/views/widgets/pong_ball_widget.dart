import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/pong/models/pong_ball.dart';

class PongBallWidget extends StatelessWidget {
  final double width;
  final double height;
  final PongBall ball;

  const PongBallWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.ball});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Positioned(
        left: ball.x - width / 2,
        top: ball.y - height / 2,
        width: width,
        height: height,
        child: Container(
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        )));
  }
}
