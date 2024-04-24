// class Game {
//   String activeTurn; // Assuming activeTurn is a string indicating the active player
//   String player; // Assuming player is a string representing the player
//   String opponent; // Assuming opponent is a string representing the opponent
  
//   // Define other properties and methods as needed
//   bool win(String player) {
//     // Implementation of the win method
//   }
  
//   bool over() {
//     // Implementation of the over method
//   }
  
//   List<String> getAvailableMoves() {
//     // Implementation of the getAvailableMoves method
//   }
  
//   Game getNewState(String move) {
//     // Implementation of the getNewState method
//   }
// }

// class Minimax {
//   String player;
//   String opponent;
//   String choice;
  
//   int score(Game game, int depth) {
//     if (game.win(player)) {
//       return 10 - depth;
//     } else if (game.win(opponent)) {
//       return depth - 10;
//     } else {
//       return 0;
//     }
//   }

//   int minimax(Game game, int depth) {
//     if (game.over()) {
//       return score(game, depth);
//     }
//     depth++;
//     List<int> scores = [];
//     List<String> moves = [];

//     game.getAvailableMoves().forEach((move) {
//       Game possibleGame = game.getNewState(move);
//       scores.add(minimax(possibleGame, depth));
//       moves.add(move);
//     });

//     int maxScoreIndex = scores.reduce((a, b) => a > b ? a : b);
//     int minScoreIndex = scores.reduce((a, b) => a < b ? a : b);

//     if (game.activeTurn == player) {
//       choice = moves[maxScoreIndex];
//       return scores[maxScoreIndex];
//     } else {
//       choice = moves[minScoreIndex];
//       return scores[minScoreIndex];
//     }
//   }
// }
