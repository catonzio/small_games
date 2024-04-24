import 'package:get/get.dart';
import 'package:small_games/app/modules/tic_tac_toe/controllers/grid_controller.dart';

import '../controllers/tic_tac_toe_controller.dart';

class TicTacToeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GridController>(() => GridController());
    Get.lazyPut<TicTacToeController>(
      () => TicTacToeController(),
    );
  }
}
