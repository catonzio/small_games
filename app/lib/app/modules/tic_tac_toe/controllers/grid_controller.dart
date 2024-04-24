import 'package:get/get.dart';

class GridController extends GetxController {
  static GridController get to => Get.find<GridController>();

  final RxList<String> grid = <String>[].obs;
  final RxList<int> winPositions = <int>[].obs;

  @override
  void onInit() {
    restart();
    super.onInit();
  }

  void play(int index, String char) {
    grid[index] = char;
    checkWin();
  }

  void restart() {
    grid.assignAll(List.generate(9, (index) => ''));
    // grid.assignAll(['X', '', 'X', '', 'X', '', 'X', '', 'X', '']);
    winPositions.assignAll([]);
  }

  void checkWin() {
    final List<List<int>> winCombination = <List<int>>[
      <int>[0, 1, 2],
      <int>[3, 4, 5],
      <int>[6, 7, 8],
      <int>[0, 3, 6],
      <int>[1, 4, 7],
      <int>[2, 5, 8],
      <int>[0, 4, 8],
      <int>[2, 4, 6],
    ];

    for (final List<int> combination in winCombination) {
      if (grid[combination[0]].isNotEmpty &&
          grid[combination[0]] == grid[combination[1]] &&
          grid[combination[1]] == grid[combination[2]]) {
        winPositions.assignAll(combination);
        return;
      }
    }
  }
}
