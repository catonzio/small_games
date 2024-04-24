import 'dart:math';

class MinimaxPlayer {
  final String player = 'O';
  final String opponent = 'X';

  int evaluateBoard(List<String> board, int depth) {
    // Checking rows for X or O victory
    for (int row = 0; row < 3; row++) {
      if (board[row * 3] == board[row * 3 + 1] &&
          board[row * 3 + 1] == board[row * 3 + 2]) {
        if (board[row * 3] == player) {
          return 10 - depth;
        } else if (board[row * 3] == opponent) {
          return -10 + depth;
        }
      }
    }

    // Checking columns for X or O victory
    for (int col = 0; col < 3; col++) {
      if (board[col] == board[col + 3] && board[col + 3] == board[col + 6]) {
        if (board[col] == player) {
          return 10 - depth;
        } else if (board[col] == opponent) {
          return -10 + depth;
        }
      }
    }

    // Checking diagonals for X or O victory
    if (board[0] == board[4] && board[4] == board[8]) {
      if (board[0] == player) {
        return 10 - depth;
      } else if (board[0] == opponent) {
        return -10 + depth;
      }
    }

    return 0;
  }

  bool isMovesLeft(List<String> board) {
    return board.any((element) => element.isEmpty);
  }

  int minimax(List<String> board, int depth, bool isMax) {
    int score = evaluateBoard(board, depth);

    // If the player has won
    if (score == 10) {
      return score;
    } else if (score == -10) {
      // If the opponent has won
      return score;
    }

    // If there are no more moves and no winner (tie)
    if (!isMovesLeft(board)) {
      return 0;
    }

    int best = 0;

    if (isMax) {
      best = -1000;
      // Traverse all the empty cells
      for (int i = 0; i < 9; i++) {
        if (board[i].isEmpty) {
          // Make the move
          board[i] = player;

          // Call minimax recursively and choose the maximum value
          best = max(best, minimax(board, depth + 1, !isMax));

          // Undo the move
          board[i] = '';
        }
      }
    } else {
      best = 1000;
      // Traverse all the empty cells
      for (int i = 0; i < 9; i++) {
        if (board[i].isEmpty) {
          // Make the move
          board[i] = opponent;

          // Call minimax recursively and choose the minimum value
          best = min(best, minimax(board, depth + 1, !isMax));

          // Undo the move
          board[i] = '';
        }
      }
    }

    return best;
  }

  int findBestMove(List<String> board) {
    int bestVal = -1000;
    int bestMove = -1;

    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        board[i] = player;

        int moveVal = minimax(board, 0, false);

        board[i] = '';

        if (moveVal > bestVal) {
          bestMove = i;
          bestVal = moveVal;
        }
      }
    }

    return bestMove;
  }
}
