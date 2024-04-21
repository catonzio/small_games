import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/views/desktop/eight_puzzle_desktop.dart';
import 'package:small_games/app/modules/eight_puzzle/views/mobile/eight_puzzle_mobile.dart';
import 'package:small_games/app/shared/responsive.dart';

class EightPuzzleView extends StatelessWidget {
  const EightPuzzleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF456685),
      appBar: AppBar(
        title: const Text('8-Puzzle'),
        centerTitle: true,
        backgroundColor: const Color(0xFF15273F),
        scrolledUnderElevation: 0,
      ),
      body: const Responsive(
        mobile: EightPuzzleMobile(),
        desktop: EightPuzzleDesktop(),
      ),
    );
  }
}