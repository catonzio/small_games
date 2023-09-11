import 'package:eight_puzzle/utilities/utils.dart';
import 'package:flutter/material.dart';

class MGridTile extends StatelessWidget {
  final int index;
  final String cellValue;
  const MGridTile({super.key, required this.index, required this.cellValue});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: getColorScheme(context).surfaceVariant,
            borderRadius: getBoxDecoration(context)),
        child: Text(
          cellValue == "0" ? "" : cellValue,
          style: getTextTheme(context).displayLarge,
        ));
  }

  BorderRadius getBoxDecoration(BuildContext context) {
    switch (index) {
      case 0:
        return const BorderRadius.only(topLeft: Radius.circular(32));
      case 2:
        return const BorderRadius.only(topRight: Radius.circular(32));
      case 6:
        return const BorderRadius.only(bottomLeft: Radius.circular(32));
      case 8:
        return const BorderRadius.only(bottomRight: Radius.circular(32));
      default:
        return BorderRadius.circular(0);
    }
  }
}
