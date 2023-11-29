import 'package:flutter/foundation.dart';
import 'dart:math' as math;
// import 'game.dart';

List<int> moveOnGrid(List<int> grid, String direction) {
  final List<int> newGrid = List.from(grid);
  int index = grid.indexWhere((element) => element == 0);

  switch (direction) {
    case "up":
      if (index > 2) {
        newGrid[index] = grid[index - 3];
        newGrid[index - 3] = 0;
      }
      break;
    case "down":
      if (index < 6) {
        newGrid[index] = grid[index + 3];
        newGrid[index + 3] = 0;
      }
      break;
    case "left":
      if (index % 3 != 0) {
        newGrid[index] = grid[index - 1];
        newGrid[index - 1] = 0;
      }
      break;
    case "right":
      if (index % 3 != 2) {
        newGrid[index] = grid[index + 1];
        newGrid[index + 1] = 0;
      }
      break;
    default:
      break;
  }
  return newGrid;
}

class State {
  // List of integers representing the state of the node
  final List<int> state;
  // The move made to go from previous to this node
  final String direction;

  State(this.state, this.direction);

  // The score of the node
  double score() {
    double score = 0;
    for (int i = 0; i < state.length; i++) {
      int row = state[i] ~/ 3;
      int col = state[i] % 3;
      int goalRow = (i == 0 ? 9 : i) ~/ 3;
      int goalCol = (i == 0 ? 9 : i) % 3;
      if (state[i] != i + 1) {
        double val = math.sqrt(row + col) + math.sqrt(goalRow + goalCol);
        score += val > 0 ? val : -val;
      }
    }
    return score;
  }

  @override
  operator ==(Object other) {
    return other is State && listEquals(other.state, state);
  }

  @override
  int get hashCode => super.hashCode ^ state.hashCode;
}

class AStar {
  // List of possible moves
  final List<String> moves = ["up", "down", "left", "right"];
  // List of visited, but not expanded nodes
  List<State> openList = [];
  // List of visited and expanded nodes
  List<State> closedList = [];

  State startState;
  State goalState;

  AStar({required this.startState, required this.goalState});

  List<String> reconstructPath(Map<State, State> cameFrom, State currentNode) {
    List<String> path = [currentNode.direction];
    while (cameFrom.containsKey(currentNode)) {
      currentNode = cameFrom[currentNode]!;
      path.add(currentNode.direction);
    }
    return path.reversed.toList();
  }

  List<String> solve({int nodeWeight = 1}) {
    print("Solving...");
    openList.add(startState);
    // For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from the start
    Map<State, State> cameFrom = {};
    // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
    Map<State, int> gScore = {};
    gScore[startState] = 0;
    // For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
    // how cheap a path from start to finish can be if it goes through n.
    Map<State, double> fScore = {};
    fScore[startState] = startState.score();
    int step = 0;
    while (openList.isNotEmpty) {
      // print("Step ${++step}");
      // sort the open list by score (lowest to highest)
      openList.sort((a, b) => a.score().compareTo(b.score()));
      // get the node with the lowest score
      State currentNode = openList[0];
      // if the current node is the final one, we are done
      if (currentNode == goalState) {
        return reconstructPath(cameFrom, currentNode);
      } else {
        // add the current node to the closed list
        closedList.add(currentNode);
      }
      // remove the current node from the open list
      openList.remove(currentNode);

      // expand the node and check its children
      List<State> children = generateSuccessors(currentNode);
      for (State child in children) {
        if (closedList.contains(child) || child == currentNode) {
          continue;
        }
        int successorScore = gScore[currentNode]! + nodeWeight;
        if (!gScore.keys.contains(child) || successorScore < gScore[child]!) {
          // This path to neighbor is better than any previous one. Record it!
          cameFrom[child] = currentNode;
          gScore[child] = successorScore;
          fScore[child] = successorScore + child.score();
          if (!openList.contains(child)) {
            openList.add(child);
          }
        }
      }
    }
    print("No solution found!");
    return [];
  }

  List<State> generateSuccessors(State currentNode) {
    return <State>[
      for (String move in moves)
        State(moveOnGrid(currentNode.state, move), move)
    ];
  }
}

// main() {
//   List<int> ss = [1, 2, 3, 4, 5, 6, 7, 8, 0];
//   ss.shuffle();
//   var res = AStar(
//           startState: State(ss, ""),
//           goalState: State([1, 2, 3, 4, 5, 6, 7, 8, 0], ""))
//       .solve();
//   print("Res: $res");
// }
