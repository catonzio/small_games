import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/pong/controllers/pong_controller.dart';
import 'package:small_games/app/modules/pong/models/pong_ball.dart';
import 'package:small_games/app/modules/pong/views/widgets/pong_ball_widget.dart';
import 'package:small_games/app/modules/pong/views/widgets/pong_bar_widget.dart';

class PongBoard extends StatelessWidget {
  const PongBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PongController controller = PongController.to;

    final double width = Size(context.width, context.height).shortestSide;
    // final double width = context.width * 0.8;
    final double height = width * 9 / 16;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
        width: width,
        color: Colors.black,
        child: MouseRegion(
          onHover: (event) =>
              controller.playerController.mouseMovement(event.localPosition),
          child: Stack(
            children: [
              PongBarWidget(
                width: 20,
                height: 150,
                bar: controller.playerController.bar,
                isPlayer: true,
              ),
              PongBarWidget(
                width: 20,
                height: 150,
                bar: controller.computerController.bar,
                isPlayer: false,
              ),
              PongBallWidget(width: 20, height: 20, ball: controller.ball)
            ],
          ),
        ),
      ),
    );
  }
}
