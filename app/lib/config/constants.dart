class Constants {
  static double mobileWidth = 868;
  static double tabletWidth = 1092;

  static String presentationText =
      "Welcome to SmallGames!\nThis is a collection of small games to play, solved by AI.\nPlease select a game to play:";

  static const String eightPuzzleDescription =
      """8-puzzle game is a sliding puzzle that consists of a frame of numbered square tiles in random order with one tile missing.
The object of the puzzle is to place the tiles in order by making sliding moves that use the empty space.
Move the tiles with arrow keys, WASD or by tapping on the cell in which you want to move the tile.
This app was intentionally built to understand how the artificial intelligence algorithms solves the n-puzzle problem, using the A* algorithm.
Developed by Danilo Catone <danilocatone@gmail.com>""";

  static const String ticTacToeDescription =
      """Tic-tac-toe is a game for two players, X and O, who take turns marking the spaces in a 3×3 grid.""";

  static const String pongDescription =
      """Pong is one of the earliest arcade video games. It is a table tennis sports game featuring simple two-dimensional graphics.""";

  static List<String> imagesList = [
    "assets/images/romance.png",
    "assets/images/adriana.png",
    "assets/images/cartoon1.png",
    "assets/images/cartoon2.png",
    "assets/images/cartoon3.png",
    "assets/images/dog.png",
    "assets/images/tiger.png",
  ];

  static const String githubRepoUrl =
      "https://github.com/catonzio/small_games/";
}
