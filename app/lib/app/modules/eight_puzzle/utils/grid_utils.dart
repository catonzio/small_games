import 'dart:math';

import 'package:small_games/app/modules/eight_puzzle/enums.dart';
import 'package:small_games/app/shared/utils.dart';

bool isSolvable(List<int> grid) {
  final int n = sqrt(grid.length).toInt();
  final int numInversions = countInversions(grid);
  // if n is odd, it's valid if the number of inversions is even
  if (n % 2 == 1) {
    return numInversions % 2 == 0;
  } else {
    // if n is even, it's valid if the number of inversions plus the row number of the empty cell is odd
    int emptyCellRow =
        grid.indexWhere((element) => element == grid.length) ~/ n;
    return (numInversions + emptyCellRow) % 2 == 1;
  }
}

int countInversions(List<int> grid) {
  final int maxNum = grid.length;
  int invCount = 0;
  for (int i = 0; i < grid.length - 1; i++) {
    for (int j = i + 1; j < grid.length; j++) {
      if (grid[j] != maxNum && grid[i] != maxNum && grid[i] > grid[j]) {
        invCount++;
      }
    }
  }
  dPrint(invCount);
  return invCount;
}

List<int> moveOnGrid(List<int> grid, Direction direction) {
  final int cellsInRow = sqrt(grid.length).toInt();
  final List<int> newGrid = List.from(grid);
  int index = grid.indexWhere((element) => element == grid.length);
  int newIndex = index;
  switch (direction) {
    case Direction.left:
      if (index % cellsInRow != 0) {
        newIndex = index - 1;
      }
      break;
    case Direction.right:
      if (index % cellsInRow != cellsInRow - 1) {
        newIndex = index + 1;
      }
      break;
    case Direction.up:
      if (index > cellsInRow - 1) {
        newIndex = index - cellsInRow;
      }
      break;

    case Direction.down:
      if (index < cellsInRow * (cellsInRow - 1)) {
        newIndex = index + cellsInRow;
      }
      break;

    default:
      break;
  }
  swapCells(newGrid, index, newIndex);
  return newGrid;
}

void swapCells(List<int> grid, int index, int newIndex) {
  int temp = grid[index];
  grid[index] = grid[newIndex];
  grid[newIndex] = temp;
}
