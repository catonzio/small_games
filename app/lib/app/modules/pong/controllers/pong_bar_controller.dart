import 'dart:ui';

import 'package:get/get.dart';
import 'package:small_games/app/modules/pong/models/pong_bar.dart';

class PongBarController extends GetxController {
  static PongBarController get to => Get.find<PongBarController>();

  final PongBar bar = PongBar();

  PongBarController();

  void mouseMovement(Offset offset) {
    bar.y = offset.dy;
  }
}
