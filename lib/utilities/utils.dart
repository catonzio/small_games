import 'package:flutter/material.dart';
import 'dart:math' as math;

double screenHeight(BuildContext context, double percent) =>
    math.min(MediaQuery.of(context).size.height, 1500) * percent / 100;

double screenWidth(BuildContext context, double percent) =>
    math.min(MediaQuery.of(context).size.width, 844) * percent / 100;

ColorScheme getColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;

TextTheme getTextTheme(BuildContext context) => Theme.of(context).textTheme;
