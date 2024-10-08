import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/grid_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';
import 'package:small_games/app/modules/eight_puzzle/solver/a_star.dart';
import 'package:small_games/app/modules/eight_puzzle/solver/state.dart';
import 'package:small_games/app/modules/eight_puzzle/utils/cropper.dart';
import 'package:small_games/app/modules/eight_puzzle/enums.dart';
import 'package:small_games/app/modules/eight_puzzle/utils/directions.dart';
import 'package:small_games/app/modules/eight_puzzle/utils/grid_utils.dart';
import 'package:small_games/config/constants.dart';

class EightPuzzleController extends GetxController
    with GetTickerProviderStateMixin {
  static EightPuzzleController get to => Get.find<EightPuzzleController>();

  final GridController grid;

  final RxBool _isLoadingImage = false.obs;
  bool get isLoadingImage => _isLoadingImage.value;
  set isLoadingImage(bool value) => _isLoadingImage.value = value;

  final RxString _imagePath = Constants.imagesList[0].obs;
  String get imagePath => _imagePath.value;
  set imagePath(String value) => _imagePath.value = value;

  final RxList<Image> _subImages = <Image>[].obs;
  List<Image> get subImages => _subImages;
  set subImages(List<Image> value) => _subImages.value = value;

  final RxBool _isSolving = false.obs;
  bool get isSolving => _isSolving.value;
  set isSolving(bool value) => _isSolving.value = value;

  final RxBool _showNumbers = false.obs;
  bool get showNumbers => _showNumbers.value;
  set showNumbers(bool value) => _showNumbers.value = value;

  final RxDouble _solvingSpeed = 400.0.obs;
  double get solvingSpeed => _solvingSpeed.value;
  set solvingSpeed(double value) => _solvingSpeed.value = value;

  final RxBool _isShowingSolvingMoves = false.obs;
  bool get isShowingSolvingMoves => _isShowingSolvingMoves.value;
  set isShowingSolvingMoves(bool value) => _isShowingSolvingMoves.value = value;

  final FocusScopeNode focusNode = FocusScopeNode();
  late final AnimationController animationController;
  late final ConfettiController confettiController;

  EightPuzzleController({required this.grid});

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    confettiController = ConfettiController(
        duration: const Duration(seconds: 1, milliseconds: 500));
    grid.initialize();
    createSubImages(imagePath);
    ever(_imagePath, (callback) => createSubImages(callback));
    ever(grid.isSolvedO,
        (callback) => callback ? confettiController.play() : null);
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    animationController.dispose();
    confettiController.dispose();
    super.dispose();
  }

  void createSubImages(String imagePath) {
    isLoadingImage = true;
    isShowingSolvingMoves = false;

    decodeAndCropImage(imagePath, grid.cellsInRow).then((List<Image> value) {
      subImages = value;
      isLoadingImage = false;
      grid.hasShuffled = false;
    });
  }

  void onShuffle() {
    if (!isShowingSolvingMoves) {
      grid.shuffle();
      focusNode.requestFocus();
    }
  }

  void setImgsInRowFromGridSize(int size) {
    if (!isShowingSolvingMoves) {
      grid.cellsInRow = sqrt(size).toInt();
      grid.initialize();
      createSubImages(imagePath);
      onShuffle();
    }
  }

  KeyEventResult onKeyMove(FocusNode node, KeyEvent event) {
    if (!isShowingSolvingMoves) {
      Direction? direction = getDirectionFromKey(event);
      if (direction != null) {
        grid.move(direction);
      }
    }
    return KeyEventResult.handled;
  }

  void onTapMove(Cell tappedCell) {
    if (!isShowingSolvingMoves) {
      final (int, int) emptyPos = grid.emptyCell.getPosition();
      final (int, int) cellPos = tappedCell.getPosition();
      Direction? direction = getDirectionFromPositions(emptyPos, cellPos);
      if (direction != null) grid.move(direction);
    }
  }

  Future<void> onSolve() async {
    if (!isShowingSolvingMoves && !isSolving) {
      AStar astar = AStar(
          startState: GameState(
            state: grid.cells.map((e) => e.value).toList(),
            direction: null,
          ),
          goalState: GameState(
            state: List.generate(grid.cells.length, (index) => index + 1),
            direction: null,
          ));

      isSolving = true;
      // List<Direction> directions =
      //     await Isolate.run<List<Direction>>(() => astar.solve());
      List<Direction> directions =
          await compute((dynamic a) => astar.solve(), 1);
      isSolving = false;

      isShowingSolvingMoves = true;
      for (Direction direction in directions) {
        if (isShowingSolvingMoves) {
          grid.move(direction);
          await Future.delayed(solvingSpeed.milliseconds);
          print("Moving $direction");
        }
      }
      isShowingSolvingMoves = false;
      // if (showSolvingMoves) {
      //   confettiController.play();
      // }
    }
  }
}
