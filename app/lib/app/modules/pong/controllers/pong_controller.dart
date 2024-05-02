import 'dart:async';

import 'package:get/get.dart';
import 'package:small_games/app/modules/pong/controllers/pong_bar_controller.dart';
import 'package:small_games/app/modules/pong/models/pong_ball.dart';

const double FPS = 30;
final int dt = (1 / FPS * 1000).toInt();

class PongController extends GetxController {
  static PongController get to => Get.find<PongController>();

  final PongBall ball = PongBall();

  final PongBarController playerController =
      Get.put<PongBarController>(PongBarController(), tag: 'player');
  final PongBarController computerController =
      Get.put<PongBarController>(PongBarController(), tag: 'computer');

  Timer? timer;

  @override
  void onInit() {
    startGame();
    super.onInit();
  }

  @override
  void dispose() {
    stopGame();
    super.dispose();
  }

  void startGame() {
    timer = Timer.periodic(Duration(milliseconds: dt), (timer) {
      ball.x = ball.x + ball.speed.dx * dt / 1000;
      ball.y = ball.x + ball.speed.dy * dt / 1000;
      print("${ball.x} ${ball.y}");
    });
  }

  void stopGame() {
    timer?.cancel();
  }
}
