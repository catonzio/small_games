import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/views/desktop/eight_puzzle_desktop.dart';
import 'package:small_games/app/modules/eight_puzzle/views/mobile/eight_puzzle_mobile.dart';
import 'package:small_games/app/shared/responsive.dart';
import 'package:small_games/app/shared/views/shared_view.dart';
import 'package:small_games/config/constants.dart';

class EightPuzzleView extends StatelessWidget {
  const EightPuzzleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedView(
        title: '8-Puzzle',
        description: Constants.eightPuzzleDescription,
        body: Responsive(
          mobile: EightPuzzleMobile(),
          desktop: EightPuzzleDesktop(),
        ));
  }
}
