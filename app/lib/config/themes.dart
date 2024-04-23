import 'package:flutter/material.dart';
import 'package:small_games/config/app_colors.dart';

class Themes {
  static ThemeData getTheme() {
    ThemeData theme = ThemeData.dark(useMaterial3: true);

    final ColorScheme colorScheme = theme.colorScheme.copyWith(
      background: AppColors.background,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
    );

    final AppBarTheme appBarTheme = theme.appBarTheme.copyWith(
      backgroundColor: AppColors.appBarBackground,
    );

    final DialogTheme dialogTheme = theme.dialogTheme.copyWith(
      backgroundColor: AppColors.background,
      // elevation: 1,
    );

    theme = theme.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: colorScheme,
      appBarTheme: appBarTheme,
      dialogTheme: dialogTheme,
      visualDensity: VisualDensity.compact,
    );

    return theme;
  }
}
