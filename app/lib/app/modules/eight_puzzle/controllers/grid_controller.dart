import 'dart:math';

import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/enums.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';
import 'package:small_games/app/modules/eight_puzzle/utils/grid_utils.dart';
import 'package:small_games/app/shared/utils.dart';

class GridController extends GetxController {
  static GridController get to => Get.find<GridController>();

  final RxInt _cellsInRow = 3.obs;
  int get cellsInRow => _cellsInRow.value;
  set cellsInRow(int value) => _cellsInRow.value = value;
  int get gridSize => pow(cellsInRow, 2).toInt();

  final RxBool _hasShuffled = false.obs;
  bool get hasShuffled => _hasShuffled.value;
  set hasShuffled(bool value) => _hasShuffled.value = value;

  final RxList<Cell> _cells = <Cell>[].obs;
  List<Cell> get cells => _cells;
  set cells(List<Cell> value) => _cells.value = value;

  final RxBool isSolvedO = false.obs;
  bool get isSolved => isSolvedO.value;
  set isSolved(bool value) => isSolvedO.value = value;

  final RxList<Direction> _moves = <Direction>[].obs;
  List<Direction> get moves => _moves;
  set moves(List<Direction> value) => _moves.value = value;

  late final Map<Direction, Function> _moveFunctions;

  Cell get emptyCell =>
      cells.firstWhere((element) => element.value == gridSize);
  int get emptyIndex =>
      cells.indexWhere((element) => element.value == gridSize);

  GridController() {
    _moveFunctions = {
      Direction.left: moveLeft,
      Direction.right: moveRight,
      Direction.up: moveUp,
      Direction.down: moveDown,
    };
  }

  void initialize() {
    isSolved = false;
    _cells.clear();
    for (int i = 0; i < cellsInRow; i++) {
      for (int j = 0; j < cellsInRow; j++) {
        _cells.add(Cell(
          row: i,
          col: j,
          value: j * cellsInRow + i + 1,
        ));
      }
    }
  }

// 21:50
  void shuffle() {
    isSolved = false;
    moves.clear();
    List<Cell> newGrid = List.from(cells);
    do {
      newGrid.shuffle();
    } while (!isSolvable(newGrid.map((e) => e.value).toList()));
    cells = newGrid;
    for (int i = 0; i < cells.length; i++) {
      int row = i ~/ cellsInRow;
      int col = i % cellsInRow;
      cells[i].setPosition((row, col));
    }
    hasShuffled = true;
  }

  void move(Direction direction) {
    int newIndex = _moveFunctions[direction]!(emptyIndex);
    if (newIndex != emptyIndex) {
      swapCells(emptyIndex, newIndex);
      moves.add(direction);
      isSolved = checkWin();
    }
  }

  bool checkWin() {
    bool win = true;
    for (int i = 0; i < cells.length; i++) {
      if (cells[i].value != i + 1) {
        win = false;
        break;
      }
    }
    return win;
  }

  int moveLeft(int index) {
    if (index % cellsInRow != 0) {
      return index - 1;
    } else {
      dPrint("Border reached  ${Direction.left}");
      return index;
    }
  }

  int moveRight(int index) {
    if (index % cellsInRow != cellsInRow - 1) {
      return index + 1;
    } else {
      dPrint("Border reached ${Direction.right}");
      return index;
    }
  }

  int moveUp(int index) {
    if (index > cellsInRow - 1) {
      return index - cellsInRow;
    } else {
      dPrint("Border reached  ${Direction.up}");
      return index;
    }
  }

  int moveDown(int index) {
    if (index < cellsInRow * (cellsInRow - 1)) {
      return index + cellsInRow;
    } else {
      dPrint("Border reached  ${Direction.right}");
      return index;
    }
  }

  void swapCells(int index, int newIndex) {
    (int, int) newPos = cells[newIndex].getPosition();
    (int, int) oldPos = cells[index].getPosition();
    Cell temp = cells[index];
    cells[index] = cells[newIndex];
    cells[newIndex] = temp;
    cells[newIndex].setPosition(newPos);
    cells[index].setPosition(oldPos);
  }
}
