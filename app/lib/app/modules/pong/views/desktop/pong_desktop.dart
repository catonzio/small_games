import 'package:flutter/material.dart';
import 'package:small_games/app/modules/pong/views/widgets/pong_board.dart';

class PongDesktop extends StatelessWidget {
  const PongDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Hello"),
          PongBoard(),
          Text("Hello"),
        ],
      ),
    );
  }
}
