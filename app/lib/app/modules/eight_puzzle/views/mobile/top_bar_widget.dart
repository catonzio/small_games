import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_games/app/modules/eight_puzzle/controllers/grid_controller.dart';
import 'package:small_games/app/modules/eight_puzzle/enums.dart';
import 'package:small_games/app/modules/eight_puzzle/widgets/grid_size_radio.dart';
import 'package:small_games/config/app_colors.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridSizeRadio(value: 9),
              GridSizeRadio(value: 16),
              // GridSizeRadio(value: 25),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() => FractionallySizedBox(
                    widthFactor: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text("Moves"),
                          const Divider(),
                          Expanded(
                            child: ListView(
                              children: _directionsToWidget(
                                      context, GridController.to.moves)
                                  .reversed
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))),
        )
      ],
    );
  }

  List<Widget> _directionsToWidget(
      BuildContext context, List<Direction> directions) {
    return [
      for (int i = 0; i < directions.length; i++)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: context.width * 0.05, child: Text("${i + 1}")),
            Text(
              directions[i].name,
              style: const TextStyle(),
            ),
          ],
        )
    ];
  }
}
