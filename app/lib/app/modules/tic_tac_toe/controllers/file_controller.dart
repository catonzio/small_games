import 'dart:io';

import 'package:small_games/app/modules/tic_tac_toe/minimax/state.dart';

class FileController {
  static Future<void> writeStates(String path, Map<int, State> states) async {
    File.fromUri(Uri.file(path))
      ..createSync(recursive: true)
      ..writeAsStringSync(states
          .map((key, value) => MapEntry('"$key"', value.toString()))
          .toString());
  }
}
