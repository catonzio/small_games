import 'package:get/get.dart';

class PongBar {
  final RxDouble _y = 0.0.obs;
  double get y => _y.value;
  set y(double value) => _y.value = value;

}
