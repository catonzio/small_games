import 'dart:ui';

import 'package:eight_puzzle/controllers/home_controller.dart';
import 'package:eight_puzzle/utilities/utils.dart';
import 'package:eight_puzzle/widgets/grid_widget.dart';
import 'package:eight_puzzle/widgets/move_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: getColorScheme(context).primary,
        //   title: const Text("Eight Puzzle"),
        // ),
        backgroundColor: getColorScheme(context).background,
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              HomeBody(),
              Obx(() => Visibility(
                    visible: !homeController.isPlaying,
                    child: PauseScreen(),
                  ))
            ],
          ),
        ));
  }
}

class HomeBody extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = getColorScheme(context);
    return Container(
      width: screenWidth(context, 100),
      color: colorScheme.primary.withOpacity(0.1),
      // decoration: BoxDecoration(
      //     // gradient: puzzleBgGradient(3
      //     color: colorScheme.background.withOpacity(0.4)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Obx(() => Text(
            //     "Solvable in ${homeController.solution.length} moves. ${homeController.isSolving ? "Solving..." : (homeController.solution.length < 2 ? "" : "Best next move: ${homeController.solution[1]}")}")),
            Obx(() => Text(homeController.solution.length < 2
                ? ""
                : "Best next move: ${homeController.solution[1]}")),
            Container(
              width: screenWidth(context, 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MenuButton(
                    onTap: () => homeController.pauseGame(),
                    bgColor: colorScheme.surface,
                    child: const Icon(Icons.pause),
                  ),
                  MenuButton(
                    onTap: () => homeController.solve(),
                    bgColor: colorScheme.surface,
                    child:
                        Text("Tip", style: getTextTheme(context).headlineLarge),
                  ),
                  MenuButton(
                    onTap: () => homeController.autosolve(),
                    bgColor: colorScheme.surface,
                    child: Text("Auto Solve",
                        textAlign: TextAlign.center,
                        style: getTextTheme(context).headlineLarge),
                  ),
                ],
              ),
            ),
            HistoryWidget(
                size: Size(screenWidth(context, 70), screenHeight(context, 60)),
                child: GridWidget(
                  size:
                      Size(screenWidth(context, 70), screenHeight(context, 40)),
                )),

            MoveWidget(
              size: Size(screenWidth(context, 50), screenHeight(context, 25)),
            )
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final Color bgColor;

  const MenuButton(
      {super.key,
      required this.onTap,
      required this.child,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // onTap: () => homeController.solve(),
      child: Container(
        width: screenHeight(context, 8),
        height: screenHeight(context, 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: bgColor,
        ),
        child: child,
      ),
    );
  }
}

class HistoryWidget extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final Widget child;
  final Size size;

  HistoryWidget({super.key, required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: getColorScheme(context).surface,
          borderRadius: BorderRadius.circular(32)),
      padding: const EdgeInsets.all(18),
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Obx(() => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimerWidget(duration: homeController.gameDuration.value),
                    Text(
                      "Total count ${homeController.moves.length}",
                      style: getTextTheme(context).headlineSmall,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  // controller: homeController.movesListController,
                  itemCount: homeController.moves.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Text(homeController
                        .moves[homeController.moves.length - 1 - index]);
                  },
                ),
              ),
              child
            ],
          )),
    );
  }
}

class TimerWidget extends StatelessWidget {
  final Duration duration;
  const TimerWidget({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
      style: getTextTheme(context).headlineSmall,
    );
  }
}

class PauseScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  PauseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          alignment: Alignment.center,
          color: getColorScheme(context).surface.withOpacity(0.8),
          width: screenWidth(context, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Pause", style: getTextTheme(context).displayLarge),
              GestureDetector(
                onTap: () => homeController.startGame(),
                child: Container(
                    width: screenWidth(context, 15),
                    height: screenWidth(context, 15),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 10,
                              offset: Offset(0, 0))
                        ],
                        color: getColorScheme(context).primary,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 48,
                    )),
              ),
              MenuButton(
                onTap: () => homeController.restart(),
                bgColor: getColorScheme(context).primary,
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ));
  }
}

// #a1c4fd → #c2e9fb

// #09203f → #537895