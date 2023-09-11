import 'dart:async';
import 'package:eight_puzzle/engine/game.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Timer? gameTimer;
  Rx<Duration> gameDuration = Duration.zero.obs;

  final Rx<Game> _game = Game().obs;
  Game get game => _game.value;

  final RxBool _isSolving = false.obs;
  bool get isSolving => _isSolving.value;
  set isSolving(bool value) => _isSolving.value = value;

  final RxBool _isPlaying = false.obs;
  bool get isPlaying => _isPlaying.value;
  set isPlaying(bool value) => _isPlaying.value = value;

  RxList<String> moves = <String>[].obs;
  RxList<String> solution = <String>[].obs;

  @override
  void onInit() {
    ServicesBinding.instance.keyboard.addHandler(moveKey);
    // Future.delayed(Duration(seconds: 3), () => isSolving = true);
    super.onInit();
  }

  @override
  void onClose() {
    ServicesBinding.instance.keyboard.removeHandler(moveKey);
    super.onClose();
  }

  void startGame() {
    isPlaying = true;
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      gameDuration.value += const Duration(seconds: 1);
    });
    // solution.value = game.solve();
  }

  void pauseGame() {
    isPlaying = false;
    gameTimer?.cancel();
  }

  void stopGame() {
    isPlaying = false;
    gameDuration.value = Duration.zero;
    gameTimer?.cancel();
  }

  void move(String direction) {
    if (game.move(direction)) {
      moves.add(direction);
      if (solution.isNotEmpty) {
        solution.clear();
        // solution.removeAt(0);
      }
      // solution.value = game.solve();
    }
    if (game.checkWin()) {
      gameTimer?.cancel();
    }
  }

  bool moveKey(KeyEvent event) {
    final key = event.logicalKey.keyLabel.toLowerCase();
    if (event is KeyDownEvent) {
      if (key.contains("arrow")) {
        move(key.replaceFirst("arrow ", ""));
      }
      switch (key) {
        case "w":
          move("up");
          break;
        case "s":
          move("down");
          break;
        case "a":
          move("left");
          break;
        case "d":
          move("right");
          break;
        default:
          break;
      }
    }
    return false;
  }

  void restart() {
    stopGame();
    game.initializeGrid();
    moves.clear();
    startGame();
  }

  void solve() {
    isSolving = !isSolving;
    game.solve().then((value) {
      solution.value = value;
      isSolving = !isSolving;
    });
  }

  Future<void> autosolve() async {
    List<String> solution = await game.solve();
    for (String move in solution) {
      this.move(move);
      // sleep(const Duration(seconds: 2));
      await Future.delayed(const Duration(milliseconds: 750));
    }
  }
}
