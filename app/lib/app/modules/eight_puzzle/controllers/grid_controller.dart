import 'dart:math';

import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/enums.dart';
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';
import 'package:small_games/app/modules/eight_puzzle/utils/grid_utils.dart';

class GridController extends GetxController {
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

  late final Map<Direction, Function> _moveFunctions;

  GridController() {
    _moveFunctions = {
      Direction.left: moveLeft,
      Direction.right: moveRight,
      Direction.up: moveUp,
      Direction.down: moveDown,
    };
  }

  void initialize() {
    _cells.clear();
    for (int i = 0; i < cellsInRow; i++) {
      for (int j = 0; j < cellsInRow; j++) {
        _cells.add(Cell(
          row: j,
          col: i,
          value: j * cellsInRow + i + 1,
        ));
      }
    }
  }
// 21:50
  void shuffle() {
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
    int index = cells.indexWhere((element) => element.value == cells.length);
    int newIndex = index;
    newIndex = _moveFunctions[direction]!(index);
    swapCells(index, newIndex);
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
      print("Border reached  ${Direction.left}");
      return index;
    }
  }

  int moveRight(int index) {
    if (index % cellsInRow != cellsInRow - 1) {
      return index + 1;
    } else {
      print("Border reached ${Direction.right}");
      return index;
    }
  }

  int moveUp(int index) {
    if (index > cellsInRow - 1) {
      return index - cellsInRow;
    } else {
      print("Border reached  ${Direction.up}");
      return index;
    }
  }

  int moveDown(int index) {
    if (index < cellsInRow * (cellsInRow - 1)) {
      return index + cellsInRow;
    } else {
      print("Border reached  ${Direction.right}");
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
