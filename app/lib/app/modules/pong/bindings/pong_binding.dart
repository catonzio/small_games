import 'package:get/get.dart';
import 'package:small_games/app/modules/pong/controllers/pong_controller.dart';

class PongBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<PongBarController>(
    //   () => PongBarController(),
    // );
    Get.lazyPut<PongController>(
      () => PongController(),
    );
  }
}
