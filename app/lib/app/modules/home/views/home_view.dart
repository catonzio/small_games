import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:small_games/app/extensions/context_extensions.dart';
import 'package:small_games/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => navigateEightPuzzle(context),
                child: const Text('Eight Puzzle'))
          ],
        ),
      ),
    );
  }

  void navigateEightPuzzle(BuildContext context) {
    context.navigator.pushNamed(Routes.eightPuzzle);
  }
}
