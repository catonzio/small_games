import 'package:flutter/material.dart';
import 'package:small_games/config/app_colors.dart';

class Themes {
  static ThemeData getTheme() {
    ThemeData theme = ThemeData.dark(useMaterial3: true);

    final ColorScheme colorScheme = theme.colorScheme.copyWith(
      background: AppColors.background,
    );

    final AppBarTheme appBarTheme = theme.appBarTheme.copyWith(
      backgroundColor: AppColors.appBarBackground,
    );

    theme = theme.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: colorScheme,
      appBarTheme: appBarTheme,
    );
    return theme;
  }
}