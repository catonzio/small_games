import 'dart:math';

import 'package:get/get.dart';

class GridController extends GetxController {
  final RxInt _cellsInRow = 3.obs;
  int get cellsInRow => _cellsInRow.value;
  set cellsInRow(int value) => _cellsInRow.value = value;
  int get gridSize => pow(cellsInRow, 2).toInt();
}