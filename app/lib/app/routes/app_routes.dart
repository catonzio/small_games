part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const eightPuzzle = _Paths.eightPuzzle;
  static const ticTacToe = _Paths.ticTacToe;

  static const List<String> games = [
    eightPuzzle,
    ticTacToe,
  ];
  static const PONG = _Paths.PONG;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const eightPuzzle = '/eight-puzzle';
  static const ticTacToe = '/tic-tac-toe';
  static const PONG = '/pong';
}
