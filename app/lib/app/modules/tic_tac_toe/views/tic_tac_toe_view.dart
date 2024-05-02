import 'package:flutter/material.dart';
import 'package:small_games/app/modules/tic_tac_toe/views/desktop/tic_tac_toe_desktop.dart';
import 'package:small_games/app/shared/responsive.dart';
import 'package:small_games/app/shared/views/shared_view.dart';
import 'package:small_games/config/constants.dart';

class TicTacToeView extends StatelessWidget {
  const TicTacToeView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const SharedView(
        title: 'Tic Tac Toe',
        description: Constants.ticTacToeDescription,
        body: Responsive(
          mobile: TicTacToeDesktop(),
          desktop: TicTacToeDesktop(),
        ));
  }
}
