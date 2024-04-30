import 'package:get/get.dart';

import '../controllers/pong_controller.dart';

class PongBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PongController>(
      () => PongController(),
    );
  }
}
