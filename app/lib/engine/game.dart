import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'a_star.dart';

class Game {
  RxList<int> grid = <int>[].obs;

  Game() {
    initializeGrid();
  }

  void initializeGrid() {
    // grid.value = [1, 2, 3, 4, 5, 6, 7, 8, 0].obs;
    do {
      grid.value = List.generate(9, (index) => index).obs;
      grid.shuffle();
    } while (!isSolvable(grid));
  }

  bool move(String direction) {
    // print(direction);
    bool success = true;
    List<int> newGrid = moveOnGrid(grid, direction);
    if (listEquals(newGrid, grid)) {
      success = false;
    } else {
      grid.value = newGrid;
    }
    return success;
  }

  bool checkWin() {
    bool win = true;
    for (int i = 0; i < 8; i++) {
      if (grid[i] != i + 1) {
        win = false;
        break;
      }
    }
    return win;
  }

  Future<List<String>> solve() async {
    return AStar(
            startState: State(grid.toList(), ""),
            goalState: State([1, 2, 3, 4, 5, 6, 7, 8, 0], ""))
        .solve()
        .where((e) => e != "")
        .toList();
  }

  int countInversions(List<int> grid) {
    int invCount = 0;
    for (int i = 0; i < grid.length - 1; i++) {
      for (int j = i + 1; j < grid.length; j++) {
        if (grid[j] != 0 && grid[i] != 0 && grid[i] > grid[j]) {
          invCount++;
        }
      }
    }
    return invCount;
  }

  bool isSolvable(List<int> grid) {
    int invCount = countInversions(grid);
    return invCount % 2 == 0;
  }
}
/*
up left up right
left down right down
*/