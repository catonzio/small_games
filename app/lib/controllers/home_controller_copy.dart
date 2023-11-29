import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeControllerCopy extends GetxController {
  RxList grid = [].obs;

  @override
  void onInit() {
    ServicesBinding.instance.keyboard.addHandler(moveKey);
    initializeGrid();
    super.onInit();
  }

  @override
  void onClose() {
    ServicesBinding.instance.keyboard.removeHandler(moveKey);
    super.onClose();
  }

  void initializeGrid() {
    grid.value = List.generate(9, (index) => index).obs;
    grid.shuffle();
  }

  void move(String direction) {
    int index = grid.indexWhere((element) => element == 0);
    switch (direction) {
      case "up":
        if (index > 2) {
          grid[index] = grid[index - 3];
          grid[index - 3] = 0;
        }
        break;
      case "down":
        if (index < 6) {
          grid[index] = grid[index + 3];
          grid[index + 3] = 0;
        }
        break;
      case "left":
        if (index % 3 != 0) {
          grid[index] = grid[index - 1];
          grid[index - 1] = 0;
        }
        break;
      case "right":
        if (index % 3 != 2) {
          grid[index] = grid[index + 1];
          grid[index + 1] = 0;
        }
        break;
      default:
    }
  }

  bool moveKey(KeyEvent event) {
    final key = event.logicalKey.keyLabel;
    print("Pressed $key");
    if (event is KeyDownEvent) {
      switch (key) {
        case "Arrow Up":
          move("up");
          break;
        case "Arrow Down":
          move("down");
          break;
        case "Arrow Left":
          move("left");
          break;
        case "Arrow Right":
          move("right");
          break;
      }
    }
    return false;
  }

  void restart() {
    initializeGrid();
  }
}
