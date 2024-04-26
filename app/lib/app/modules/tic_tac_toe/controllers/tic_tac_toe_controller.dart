import 'package:get/get.dart';
import 'package:small_games/app/modules/tic_tac_toe/controllers/grid_controller.dart';
import 'package:small_games/app/modules/tic_tac_toe/minimax/minimax_player.dart';

class TicTacToeController extends GetxController {
  static TicTacToeController get to => Get.find<TicTacToeController>();

  final GridController gridController = GridController.to;

  final RxBool _firstPlayerTurn = true.obs;
  bool get firstPlayerTurn => _firstPlayerTurn.value;
  set firstPlayerTurn(bool value) => _firstPlayerTurn.value = value;

  final MinimaxPlayer minimaxPlayer = MinimaxPlayer();

  String char(bool firstPlayerTurn) => firstPlayerTurn ? 'X' : 'O';

  void onPlay(int index) {
    gridController.play(index, char(firstPlayerTurn));
    if (gridController.winPositions.isNotEmpty) return;
    firstPlayerTurn = !firstPlayerTurn;
    playMinimax();
  }

  void playMinimax() {
    int bestMove = minimaxPlayer.findBestMove(gridController.grid);
    if (bestMove != -1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        gridController.play(bestMove, char(firstPlayerTurn));
        if (gridController.winPositions.isNotEmpty) return;
        firstPlayerTurn = !firstPlayerTurn;
      });
    }
  }

  void restartGame() {
    gridController.restart();
    firstPlayerTurn = true;
  }

  RxBool isWinningPosition(int index) {
    return gridController.winPositions.contains(index).obs;
  }
}
