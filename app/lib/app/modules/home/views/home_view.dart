import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:small_games/app/extensions/context_extensions.dart';
import 'package:small_games/app/routes/app_pages.dart';
import 'package:small_games/app/shared/widgets/app_button.dart';
import 'package:small_games/config/constants.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmallGames'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: context.theme.textTheme.headlineSmall!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: Constants.presentationText
                      .split("\n")
                      .map((e) => Text(e))
                      .toList(),
                ),
              ),
              AppButton(
                onPressed: () => navigateEightPuzzle(context),
                text: 'Eight Puzzle',
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateEightPuzzle(BuildContext context) {
    context.navigator.pushNamed(Routes.eightPuzzle);
  }
}
