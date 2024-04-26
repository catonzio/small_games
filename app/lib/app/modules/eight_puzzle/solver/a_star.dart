import 'package:small_games/app/modules/eight_puzzle/enums.dart';
import 'package:small_games/app/modules/eight_puzzle/utils/grid_utils.dart';
import 'package:small_games/app/shared/utils.dart';

import 'state.dart';

class AStar {
  // List of possible moves
  final List<Direction> moves = Direction.values;
  // List of visited, but not expanded nodes
  List<GameState> openList = [];
  // List of visited and expanded nodes
  List<GameState> closedList = [];

  GameState startState;
  GameState goalState;

  AStar({required this.startState, required this.goalState});

  List<Direction> reconstructPath(
      Map<GameState, GameState> cameFrom, GameState currentNode) {
    List<Direction> path = [currentNode.direction!];
    while (cameFrom.containsKey(currentNode)) {
      currentNode = cameFrom[currentNode]!;
      if (currentNode.direction != null) {
        path.add(currentNode.direction!);
      }
    }
    return path.reversed.toList();
  }

  List<Direction> solve() {
    if (startState == goalState) {
      return [];
    }
    const int nodeWeight = 1;
    dPrint("Solving...");
    openList.add(startState);
    // For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from the start
    Map<GameState, GameState> cameFrom = {};
    // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
    Map<GameState, double> gScore = {};
    gScore[startState] = 0;
    // For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
    // how cheap a path from start to finish can be if it goes through n.
    Map<GameState, double> fScore = {};
    fScore[startState] = startState.score();
    // int step = 0;
    while (openList.isNotEmpty) {
      // dPrint("Step ${++step}");
      // sort the open list by score (lowest to highest)
      openList.sort((a, b) => a.score().compareTo(b.score()));
      // get the node with the lowest score
      GameState currentNode = openList[0];
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
      List<GameState> children = generateSuccessors(currentNode);
      for (GameState child in children) {
        if (closedList.contains(child) || child == currentNode) {
          continue;
        }
        double successorScore = gScore[currentNode]! + nodeWeight;
        if (!gScore.keys.contains(child) ||
            successorScore < (gScore[child] ?? 999999)) {
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
    dPrint("No solution found!");
    return [];
  }

  List<GameState> generateSuccessors(GameState currentNode) {
    return <GameState>[
      for (Direction move in moves)
        GameState(state: moveOnGrid(currentNode.state, move), direction: move)
    ];
  }
}
