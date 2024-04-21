import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/grid_controller.dart';

import '../controllers/eight_puzzle_controller.dart';

class EightPuzzleBinding extends Bindings {
  @override
  void dependencies() {
    GridController gridController = Get.put(GridController());
    Get.put(EightPuzzleController(gridController: gridController));
    // Get.lazyPut<EightPuzzleController>(
    //   () => EightPuzzleController(),
    // );
  }
}
