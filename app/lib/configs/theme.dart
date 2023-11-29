import 'package:flutter/material.dart';

ThemeData buildTheme(String theme) {
  ThemeData lightTheme = ThemeData.light(useMaterial3: true);
  lightTheme =
      lightTheme.copyWith(colorScheme: lightTheme.colorScheme.copyWith());

  ThemeData darkTheme = ThemeData.dark(useMaterial3: true);
  darkTheme = darkTheme.copyWith(colorScheme: darkTheme.colorScheme.copyWith());

  switch (theme) {
    case "light":
      return lightTheme;
    case "dark":
      return darkTheme;
    default:
      return lightTheme;
  }
}
