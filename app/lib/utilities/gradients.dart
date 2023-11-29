import 'package:flutter/material.dart';

LinearGradient scaffoldBgGradient() {
  return const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFF030811),
      Color(0xFF0e1318),
      Color(0xFF161b1e),
      Color(0xFF1e2224),
      Color(0xFF26292a)
    ],
  );
}

LinearGradient puzzleBgGradient() {
  return LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Colors.green[100]!,
      Colors.green[300]!,
      Colors.green[500]!,
      Colors.green[700]!,
      Colors.green[900]!,
    ],
  );
}
