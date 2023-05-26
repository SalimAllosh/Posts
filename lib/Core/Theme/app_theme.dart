import 'package:flutter/material.dart';
import 'package:posts_app/Core/Colors/app_colors.dart';
import 'package:posts_app/Core/Font%20Styles/font_styles.dart';

class AppThemes {
  static ThemeData light = ThemeData(
      colorScheme: AppColors.lightColorScheme,
      primarySwatch:
          MaterialColor(AppColors.fiordColor.value, AppColors.fiordColorShades),
      textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLargeTextStyle,
          displayMedium: AppTextStyles.displayMediumTextStyle,
          displaySmall: AppTextStyles.displaySmallTextStyle));

  static ThemeData dark = ThemeData(
      colorScheme: AppColors.darkColorScheme,
      primarySwatch: MaterialColor(
          const Color.fromARGB(255, 0, 0, 0).value, AppColors.darkColorShades),
      textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLargeTextStyleGray,
          displayMedium: AppTextStyles.displayMediumTextStyleGray,
          displaySmall: AppTextStyles.displaySmallTextStyleGray));
}
