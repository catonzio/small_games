import 'package:flutter/services.dart';
import 'package:small_games/app/modules/eight_puzzle/enums.dart';

Direction? getDirectionFromKey(KeyEvent event) {
  if (event.runtimeType == KeyDownEvent) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.keyW) {
      return Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.keyS) {
      return Direction.down;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.keyA) {
      return Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.keyD) {
      return Direction.right;
    }
  }
  return null;
}