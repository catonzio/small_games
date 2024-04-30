import 'package:small_games/app/modules/tic_tac_toe/minimax/constants.dart';

class State {
  double _value;
  final int id;
  final List<String> board;
  final int depth;
  final bool isMaxNode;
  final List<State> children = [];

  State(this._value, this.board, this.depth, this.isMaxNode)
      : id = board.hashCode;

  double get value => _value;
  set value(double value) => _value = value;

  void addChild(State board) {
    children.add(board);
  }

  void addChildren(List<State> boards) {
    children.addAll(boards);
  }

  /// Get all the actions that can be performed on the board
  List<int> actions() {
    return board.indexed.where((e) => e.$2.isEmpty).map((e) => e.$1).toList();
  }

  /// Create a new state with the action applied
  State result(int action, String player) {
    List<String> newBoard = List<String>.from(board);
    newBoard[action] = player;
    return State(0, newBoard, depth + 1, !isMaxNode);
  }

  /// For each action, create a new state and add it to the children list
  List<State> expand() {
    List<State> children = actions()
        .map((int action) => result(action, isMaxNode ? maxPlayer : minPlayer))
        .toList();
    addChildren(children);
    return children;
  }

  double computeOpenPoints(String opponentPlayer) {
    double score = 0.0;

    for (int row = 0; row < 3; row++) {
      if (!board.sublist(row * 3, row * 3 + 3).contains(opponentPlayer)) {
        score += 1;
      }
    }

    for (int col = 0; col < 3; col++) {
      if (!(board[col] == opponentPlayer) &&
          !(board[col + 3] == opponentPlayer) &&
          !(board[col + 6] == opponentPlayer)) {
        score += 1;
      }
    }

    if (!(board[0] == opponentPlayer) &&
        !(board[4] == opponentPlayer) &&
        !(board[8] == opponentPlayer)) {
      score += 1;
    }

    if (!(board[2] == opponentPlayer) &&
        !(board[4] == opponentPlayer) &&
        !(board[6] == opponentPlayer)) {
      score += 1;
    }
    return score;
  }

  /// Evaluate the board and return the score
  double evaluate() {
    double score = evaluateBoard();
    return score;
    // if (score == 0 && board.any((element) => element.isEmpty)) {
    //   return evaluateIncomplete();
    // } else {
    //   return score;
    // }
  }

  double evaluateIncomplete() {
    // check for open columns, rows, and diagonals for X player
    double maxScore = computeOpenPoints(minPlayer);
    // check for open columns, rows, and diagonals for O player
    double minScore = computeOpenPoints(maxPlayer);

    return maxScore - minScore;
  }

  /// Evaluate the board checking for a win
  double evaluateBoard() {
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

  @override
  String toString() {
    return {
      '"id"': id,
      '"depth"': depth,
      '"value"': value,
      '"isMaxNode"': isMaxNode,
      '"board"': "\"$board\"",
      '"children"': children.map((e) => e.id).toList().toString(),
    }.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is State &&
          id == other.id &&
          other.board == board &&
          other.depth == depth &&
          other.isMaxNode == isMaxNode;

  @override
  int get hashCode =>
      id.hashCode ^
      value.hashCode ^
      board.hashCode ^
      depth.hashCode ^
      isMaxNode.hashCode;
}
