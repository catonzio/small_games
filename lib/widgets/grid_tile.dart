import 'package:eight_puzzle/utilities/utils.dart';
import 'package:flutter/material.dart';

class MGridTile extends StatelessWidget {
  final String cellValue;
  const MGridTile({super.key, required this.cellValue});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        color: getColorScheme(context).surface, // colorScheme.secondary,
        alignment: Alignment.center,
        child: Text(
          cellValue == "0" ? "" : cellValue,
          style: const TextStyle(color: Colors.white, fontSize: 48),
        ));
  }
}
