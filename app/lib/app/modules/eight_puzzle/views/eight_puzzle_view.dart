import 'package:flutter/material.dart';
import 'package:small_games/app/modules/eight_puzzle/views/desktop/eight_puzzle_desktop.dart';
import 'package:small_games/app/modules/eight_puzzle/views/mobile/eight_puzzle_mobile.dart';
import 'package:small_games/app/shared/responsive.dart';
import 'package:small_games/app/shared/widgets/github_button.dart';
import 'package:small_games/config/app_colors.dart';
import 'package:small_games/config/constants.dart';

class EightPuzzleView extends StatelessWidget {
  const EightPuzzleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('8-Puzzle'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.appBarBackground,
        scrolledUnderElevation: 0,
        actions: _appBarActions(context),
      ),
      body: const Responsive(
        mobile: EightPuzzleMobile(),
        desktop: EightPuzzleDesktop(),
      ),
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    return [
      IconButton(
        color: AppColors.primary,
        onPressed: () => _showInfoDialog(context),
        icon: const Icon(Icons.info),
        tooltip: "Info",
      ),
      const GithubButton(),
    ];
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('8-Puzzle'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              )
            ],
            content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Constants.eightPuzzleDescription
                    .split("\n")
                    .map((e) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(e)))
                    .toList()));
      },
    );
  }
}
