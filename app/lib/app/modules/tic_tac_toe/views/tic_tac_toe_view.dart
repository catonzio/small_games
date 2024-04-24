import 'package:flutter/material.dart';
import 'package:small_games/app/modules/tic_tac_toe/views/desktop/tic_tac_toe_desktop.dart';
import 'package:small_games/app/modules/tic_tac_toe/views/mobile/tic_tac_toe_mobile.dart';

import 'package:small_games/app/shared/responsive.dart';
import 'package:small_games/app/shared/widgets/github_button.dart';
import 'package:small_games/config/app_colors.dart';
import 'package:small_games/config/constants.dart';

class TicTacToeView extends StatelessWidget {
  const TicTacToeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.appBarBackground,
        scrolledUnderElevation: 0,
        actions: _appBarActions(context),
      ),
      body: const Responsive(
        mobile: TicTacToeMobile(),
        desktop: TicTacToeDesktop(),
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
            title: const Text('Tic Tac Toe'),
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
                children: Constants.ticTacToeDescription
                    .split("\n")
                    .map((e) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(e)))
                    .toList()));
      },
    );
  }
}
