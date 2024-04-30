import 'dart:io';
import 'dart:math';

// import 'package:small_games/app/modules/tic_tac_toe/minimax/constants.dart';
import 'package:small_games/app/modules/tic_tac_toe/controllers/file_controller.dart';
// import 'package:small_games/app/modules/tic_tac_toe/controllers/tree_controller.dart';
import 'package:small_games/app/modules/tic_tac_toe/minimax/state.dart';

class MinimaxPlayer {
  final Map<int, State> states = {};
  final double maxDepth = double.infinity;
  late int moveNumber;
  late String folder;

  // final TreeController treeController = TreeController.to;

  final String savePath = 'prove/input';

  MinimaxPlayer() {
    restart();
  }

  Map<int, State> navigateTree(State root) {
    Map<int, State> path = {root.id: root};

    for (State child in root.children) {
      path.addAll(navigateTree(child));
    }

    return path;
  }

  double minimax(State state) {
    if (state.depth >= maxDepth) {
      return state.evaluateIncomplete();
    }

    double score = state.evaluate();
    if (score != 0) {
      state.value = score;
      return score;
    }

    if (state.isMaxNode) {
      double value = double.negativeInfinity;
      state.expand();
      for (State child in state.children) {
        value = max(value, minimax(child));
        // child.value = value;
      }
      if (value == double.negativeInfinity) {
        value = 0;
        // print("Value is negative infinity");
      }
      state.value = value;
      return value;
    } else {
      double value = double.infinity;
      state.expand();
      for (State child in state.children) {
        value = min(value, minimax(child));
        // child.value = value;
      }
      if (value == double.infinity) {
        value = 0;
        // print("Value is infinity");
      }
      state.value = value;
      return value;
    }
  }

  int findBestMove(List<String> board) {
    bool isMax = true;
    State root = State(0, board, 0, isMax);

    List<int> actions = root.actions();
    if (actions.isEmpty) {
      return -1;
    }

    List<State> children = root.expand();
    List<double> scores = children.map((child) => minimax(child)).toList();

    for ((int, double) idxScore in scores.indexed) {
      children[idxScore.$1].value = idxScore.$2;
    }

    if (isMax) {
      root.value = scores.reduce(max);
    }

    writeToFile(root);
    // treeController.states = navigateTree(root);
    // treeController.generateGraph();
    moveNumber++;
    return actions[scores.indexOf(scores.reduce(max))];
  }

  void writeToFile(State root) {
    if (Platform.isWindows) {
      Map<int, State> states = navigateTree(root);

      FileController.writeStates(
          "$savePath/$folder/tree_$moveNumber.json", states);
    }
  }

  void restart() {
    moveNumber = 0;
    DateTime dt = DateTime.now().toLocal();
    // treeController.restart();
    folder =
        "match_${dt.day}_${dt.month}_${dt.year}_${dt.hour}_${dt.minute}_${dt.second}";
  }
}
