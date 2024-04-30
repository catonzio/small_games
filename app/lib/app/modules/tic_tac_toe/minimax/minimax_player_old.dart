// import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';

class MinimaxPlayerOld {
  final String maxPlayer = 'O'; // max
  final String minPlayer = 'X'; // min
  final double depthWeight = 1;

  // final Map<String, List> memory = {
  //   'boards': <List<String>>[],
  //   'scores': <int>[],
  //   'moves': <int>[],
  // };

  List<int> actions(List<String> board) {
    return board.indexed.where((e) => e.$2.isEmpty).map((e) => e.$1).toList();
  }

  List<String> result(List<String> state, int action) {
    List<String> newState = List<String>.from(state);
    newState[action] = maxPlayer;
    return newState;
  }

  double evaluate(List<String> state, int depth) {
    if (state.any((element) => element.isEmpty)) {
      return evaluateIncomplete(state, depth);
    } else {
      return evaluateBoard(state, depth);
    }
  }

  double computeOpenPoints(List<String> state, String opponentPlayer) {
    double score = 0.0;

    for (int row = 0; row < 3; row++) {
      if (!state.sublist(row * 3, row * 3 + 3).contains(opponentPlayer)) {
        score += 1;
      }
    }

    for (int col = 0; col < 3; col++) {
      if (!(state[col] == opponentPlayer) &&
          !(state[col + 3] == opponentPlayer) &&
          !(state[col + 6] == opponentPlayer)) {
        score += 1;
      }
    }

    if (!(state[0] == opponentPlayer) &&
        !(state[4] == opponentPlayer) &&
        !(state[8] == opponentPlayer)) {
      score += 1;
    }

    if (!(state[2] == opponentPlayer) &&
        !(state[4] == opponentPlayer) &&
        !(state[6] == opponentPlayer)) {
      score += 1;
    }
    return score;
  }

  double evaluateIncomplete(List<String> state, int depth) {
    // check for open columns, rows, and diagonals for X player
    double maxScore = computeOpenPoints(state, minPlayer);
    // check for open columns, rows, and diagonals for O player
    double minScore = computeOpenPoints(state, maxPlayer);

    return maxScore - minScore;
  }

  double evaluateBoard(List<String> board, int depth) {
    // Checking rows for X or O victory
    for (int row = 0; row < 3; row++) {
      if (board[row * 3] == board[row * 3 + 1] &&
          board[row * 3 + 1] == board[row * 3 + 2]) {
        if (board[row * 3] == maxPlayer) {
          return 10 - depth * depthWeight;
        } else if (board[row * 3] == minPlayer) {
          return -10 + depth * depthWeight;
        }
      }
    }

    // Checking columns for X or O victory
    for (int col = 0; col < 3; col++) {
      if (board[col] == board[col + 3] && board[col + 3] == board[col + 6]) {
        if (board[col] == maxPlayer) {
          return 10 - depth * depthWeight;
        } else if (board[col] == minPlayer) {
          return -10 + depth * depthWeight;
        }
      }
    }

    // Checking diagonals for X or O victory
    if (board[0] == board[4] && board[4] == board[8]) {
      if (board[0] == maxPlayer) {
        return 10 - depth * depthWeight;
      } else if (board[0] == minPlayer) {
        return -10 + depth * depthWeight;
      }
    }

    // Checking  reverse diagonals for X or O victory
    if (board[2] == board[4] && board[4] == board[6]) {
      if (board[0] == maxPlayer) {
        return 10 - depth * depthWeight;
      } else if (board[0] == minPlayer) {
        return -10 + depth * depthWeight;
      }
    }

    // board.indexed.forEach(
    //     (e) => e.$1 % 3 == 2 ? stdout.write("${e.$2}\n") : stdout.write(e.$2));

    return 0;
  }

  bool isMovesLeft(List<String> board) {
    return board.any((element) => element.isEmpty);
  }

  double minimax(List<String> board, int depth, bool isMax) {
    double score = evaluateBoard(board, depth);

    // If the player has won
    if (score == (10 - depth * depthWeight) ||
        score == (-10 + depth * depthWeight)) {
      return score;
    }
    // If there are no more moves and no winner (tie)
    if (!isMovesLeft(board)) {
      return 0;
    }

    double best = 0;

    if (isMax) {
      // for each possible move (index of empty cells)
      best = -1000;
      List<int> moves = actions(board);
      // compute the minimax value of the move
      List<double> values = moves.map((e) {
        board[e] = maxPlayer;
        double value = max(best, minimax(board, depth + 1, !isMax));
        board[e] = '';
        return value;
      }).toList();
      // return the move with the maximum value
      best = values.reduce(max);

      // // Traverse all the empty cells
      // for (int i = 0; i < 9; i++) {
      //   if (board[i].isEmpty) {
      //     // Make the move
      //     board[i] = player;

      //     // Call minimax recursively and choose the maximum value
      //     best = max(best, minimax(board, depth + 1, !isMax));

      //     // Undo the move
      //     board[i] = '';
      //   }
      // }
    } else {
      best = 1000;
      List<int> moves = actions(board);
      // compute the minimax value of the move
      List<double> values = moves.map((e) {
        board[e] = minPlayer;
        double value = min(best, minimax(board, depth + 1, !isMax));
        board[e] = '';
        return value;
      }).toList();
      // return the move with the maximum value
      best = values.reduce(min);
      // // Traverse all the empty cells
      // for (int i = 0; i < 9; i++) {
      //   if (board[i].isEmpty) {
      //     // Make the move
      //     board[i] = opponent;

      //     // Call minimax recursively and choose the minimum value
      //     best = min(best, minimax(board, depth + 1, !isMax));

      //     // Undo the move
      //     board[i] = '';
      //   }
      // }
    }

    return best;
  }

  int findBestMove(List<String> board) {
    if (listEquals(board, ["O", "", "X", "", "", "", "", "", "X"])) {
      print('here');
    }
    // for each possible move (index of empty cells)
    List<int> moves = actions(board);
    // compute the minimax value of the move
    List<double> values = moves.map((e) {
      board[e] = maxPlayer;
      double value = minimax(board, 0, false);
      board[e] = '';
      return value;
    }).toList();
    // return the move with the maximum value
    if (values.isEmpty) {
      return -1;
    }
    return moves[values.indexOf(values.reduce(max))];

    // int bestVal = -1000;
    // int bestMove = -1;

    // if (memory['boards']?.contains(board) ?? false) {
    //   int index = memory['boards']?.indexOf(board) ?? -1;
    //   if (index != -1) {
    //     int move = memory['moves']?[index] ?? -1;
    //     print('Memory hit: $move');
    //     return move;
    //   }
    // }

    // for (int i = 0; i < 9; i++) {
    //   if (board[i].isEmpty) {
    //     board[i] = player;

    //     int moveVal = minimax(board, 1, false);

    //     board[i] = '';

    //     if (moveVal > bestVal) {
    //       bestMove = i;
    //       bestVal = moveVal;
    //     }
    //   }
    // }

    // // memory['boards']?.add(board);
    // // memory['scores']?.add(bestVal);
    // // memory['moves']?.add(bestMove);

    // return bestMove;
  }
}
