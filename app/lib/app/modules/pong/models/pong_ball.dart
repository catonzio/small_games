import 'dart:ui';

import 'package:get/get.dart';

class PongBall {
  double radius;
  final RxDouble _x = 0.0.obs;
  double get x => _x.value;
  set x(double value) => _x.value = value;

  final RxDouble _y = 0.0.obs;
  double get y => _y.value;
  set y(double value) => _y.value = value;

  final Rx<Offset> _speed = const Offset(100, 100).obs;
  Offset get speed => _speed.value;
  set speed(Offset value) => _speed.value = value;

  PongBall({
    this.radius = 10,
  });
}
