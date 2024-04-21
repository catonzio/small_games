import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/grid_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/cropper.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/body_grid.dart';
import 'package:small_games/config/constants.dart';

class EightPuzzleController extends GetxController
    with GetTickerProviderStateMixin {
  static EightPuzzleController get to => Get.find<EightPuzzleController>();

  final GridController gridController;

  final RxInt _cellsInRow = 3.obs;
  int get cellsInRow => _cellsInRow.value;
  set cellsInRow(int value) => _cellsInRow.value = value;
  int get gridSize => pow(cellsInRow, 2).toInt();

  final RxBool _isLoadingImage = false.obs;
  bool get isLoadingImage => _isLoadingImage.value;
  set isLoadingImage(bool value) => _isLoadingImage.value = value;

  final RxBool _hasShuffled = false.obs;
  bool get hasShuffled => _hasShuffled.value;
  set hasShuffled(bool value) => _hasShuffled.value = value;

  final RxString _imagePath = Constants.imagesList[0].obs;
  String get imagePath => _imagePath.value;
  set imagePath(String value) => _imagePath.value = value;

  final RxList<Cell> _subImages = <Cell>[].obs;
  List<Cell> get subImages => _subImages;
  set subImages(List<Cell> value) => _subImages.value = value;

  final FocusScopeNode focusNode = FocusScopeNode();
  late final AnimationController animationController;

  EightPuzzleController({required this.gridController});

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    createSubImages(imagePath);
    ever(_imagePath, (callback) => createSubImages(callback));
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void createSubImages(String imagePath) {
    isLoadingImage = true;
    decodeAndCropImage(imagePath, cellsInRow).then((List<Cell> value) {
      subImages = value;
      isLoadingImage = false;
      hasShuffled = false;
    });
  }

  void shuffle() {
    _subImages.shuffle();
    for (int i = 0; i < subImages.length; i++) {
      int row = i ~/ cellsInRow;
      int col = i % cellsInRow;
      subImages[i].setPosition((row, col));
    }
    hasShuffled = true;
    focusNode.requestFocus();
  }

  void setImgsInRowFromGridSize(int size) {
    cellsInRow = sqrt(size).toInt();
    createSubImages(imagePath);
    shuffle();
  }

  void move(Direction direction) {
    List<Cell> newGrid = moveOnGrid(subImages, direction, cellsInRow);
    subImages = newGrid;
  }
}

List<Cell> moveOnGrid(List<Cell> grid, Direction direction, int cellsInRow) {
  final List<Cell> newGrid = List.from(grid);
  int index = grid.indexWhere((element) => element.value == grid.length);
  int newIndex = index;
  switch (direction) {
    case Direction.left:
      if (index % cellsInRow != 0) {
        newIndex = index - 1;
      } else {
        print("Border reached  ${Direction.left}");
      }
      break;
    case Direction.right:
      if (index % cellsInRow != cellsInRow - 1) {
        newIndex = index + 1;
      } else {
        print("Border reached ${Direction.right}");
      }
      break;
    case Direction.up:
      if (index > cellsInRow - 1) {
        newIndex = index - cellsInRow;
      } else {
        print("Border reached  ${Direction.up}");
      }
      break;

    case Direction.down:
      if (index < cellsInRow * (cellsInRow - 1)) {
        newIndex = index + cellsInRow;
      } else {
        print("Border reached  ${Direction.right}");
      }
      break;

    default:
      break;
  }
  swapCells(newGrid, index, newIndex);
  return newGrid;
}

void swapCells(List<Cell> grid, int index, int newIndex) {
  (int, int) newPos = grid[newIndex].getPosition();
  (int, int) oldPos = grid[index].getPosition();
  Cell temp = grid[index];
  grid[index] = grid[newIndex];
  grid[newIndex] = temp;
  grid[newIndex].setPosition(newPos);
  grid[index].setPosition(oldPos);
}
