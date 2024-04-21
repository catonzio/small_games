import 'package:flutter/material.dart';

class UpperButtons extends StatelessWidget {
  const UpperButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(onPressed: null, icon: Icon(Icons.pause)),
        IconButton(onPressed: null, icon: Icon(Icons.play_arrow)),
      ],
    );
  }
}