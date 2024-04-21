import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cell {
  RxInt _row = 0.obs;
  RxInt _col = 0.obs;
  int get row => _row.value;
  int get col => _col.value;
  set row(int value) => _row.value = value;
  set col(int value) => _col.value = value;

  final int value;
  final Image image;

  Cell(
      {required int row,
      required int col,
      required this.value,
      required this.image}) {
    _row = row.obs;
    _col = col.obs;
  }

  void setRow(int row) => this.row = row;
  void setCol(int col) => this.col = col;
  (int, int) getPosition() => (row, col);
  void setPosition((int, int) position) {
    row = position.$1;
    col = position.$2;
  }

  @override
  String toString() {
    return 'Cell{row: $row, col: $col, value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cell &&
          other.row == row &&
          other.col == col &&
          other.value == value;

  @override
  int get hashCode => row.hashCode ^ col.hashCode ^ value.hashCode;
}
