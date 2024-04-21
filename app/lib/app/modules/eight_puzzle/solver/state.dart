import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:small_games/app/modules/eight_puzzle/enums.dart';

class GameState {
  final List<int> state;
  final Direction? direction;

  GameState({required this.state, this.direction});

  double score() {
    final int cellsInRow = sqrt(state.length).toInt();
    double score = 0;
    for (int i = 0; i < state.length; i++) {
      if (state[i] != i + 1) {
        int row = state[i] ~/ cellsInRow;
        int col = state[i] % cellsInRow;
        int goalRow = (i + 1) ~/ cellsInRow;
        int goalCol = (i + 1) % cellsInRow;
        double val = sqrt(row + col) + sqrt(goalRow + goalCol);
        score += val > 0 ? val : -val;
      }
    }
    return score;
  }

  @override
  operator ==(Object other) {
    return other is GameState && listEquals(other.state, state);
  }

  @override
  int get hashCode => super.hashCode ^ state.hashCode;
}
