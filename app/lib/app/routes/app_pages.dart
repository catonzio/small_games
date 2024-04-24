import 'package:get/get.dart';

import '../modules/eight_puzzle/bindings/eight_puzzle_binding.dart';
import '../modules/eight_puzzle/views/eight_puzzle_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/tic_tac_toe/bindings/tic_tac_toe_binding.dart';
import '../modules/tic_tac_toe/views/tic_tac_toe_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.eightPuzzle,
      page: () => const EightPuzzleView(),
      binding: EightPuzzleBinding(),
    ),
    GetPage(
      name: _Paths.ticTacToe,
      page: () => const TicTacToeView(),
      binding: TicTacToeBinding(),
    ),
  ];
}
