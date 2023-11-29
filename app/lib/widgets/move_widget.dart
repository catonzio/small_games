import 'package:eight_puzzle/widgets/move_arrow.dart';
import 'package:flutter/material.dart';

class MoveWidget extends StatelessWidget {
  final Size size;
  const MoveWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          // mainAxisExtent: size.height / 3,
          mainAxisSpacing: size.height / 15,
          crossAxisSpacing: size.width / 15,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return MoveArrow(index: index);
        },
      ),
    );
  }
}
