import 'dart:ui';

import 'package:eight_puzzle/controllers/home_controller.dart';
import 'package:eight_puzzle/utilities/gradients.dart';
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
        body: Container(
            decoration: BoxDecoration(gradient: scaffoldBgGradient()),
            alignment: Alignment.center,
            child: Container(
              width: screenWidth(context, 100),
              decoration: BoxDecoration(
                  // gradient: puzzleBgGradient(3
                  color: getColorScheme(context).background.withOpacity(0.4)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getColorScheme(context).surface,
                          ),
                          child: IconButton(
                              color: getColorScheme(context).onSurface,
                              onPressed: () => homeController.restart(),
                              icon: const Icon(Icons.refresh)),
                        )
                      ],
                    ),
                    GridWidget(
                      size: Size(
                          screenWidth(context, 70), screenHeight(context, 50)),
                    ),
                    // SizedBox(height: screenHeight(context, 10)),
                    MoveWidget(
                      size: Size(
                          screenWidth(context, 40), screenHeight(context, 25)),
                    )
                  ],
                ),
              ),
            )));
  }
}


// #a1c4fd → #c2e9fb

// #09203f → #537895