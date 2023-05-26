import 'package:flutter/material.dart';

class AppColors {
  static const fiordColor = Color(0xff3c486b);
  static const grayColor = Color(0xffF0F0F0);
  static const yellowColor = Color(0xffF9D949);
  static const redColor = Color(0xffF45050);
  static const darkColor = Color.fromARGB(0, 11, 11, 11);

  static const fiordColorShades = {
    50: Color.fromRGBO(25, 72, 107, 1),
    100: Color.fromRGBO(50, 72, 107, 1),
    200: Color.fromRGBO(75, 72, 107, 1),
    300: Color.fromRGBO(100, 72, 107, 1),
    400: Color.fromRGBO(125, 72, 107, 1),
    500: Color.fromRGBO(150, 72, 107, 1),
    600: Color.fromRGBO(175, 72, 107, 1),
    700: Color.fromRGBO(200, 72, 107, 1),
    800: Color.fromRGBO(225, 72, 107, 1),
    900: Color.fromRGBO(250, 72, 107, 1),
  };

  static const darkColorShades = {
    50: Color.fromARGB(255, 0, 0, 0),
    100: Color.fromARGB(250, 0, 0, 0),
    200: Color.fromRGBO(225, 0, 0, 0),
    300: Color.fromRGBO(200, 0, 0, 0),
    400: Color.fromRGBO(175, 0, 0, 0),
    500: Color.fromRGBO(150, 0, 0, 0),
    600: Color.fromRGBO(125, 0, 0, 0),
    700: Color.fromRGBO(100, 0, 0, 0),
    800: Color.fromRGBO(75, 0, 0, 0),
    900: Color.fromRGBO(50, 0, 0, 0),
  };

  static const ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.fiordColor,
      onPrimary: AppColors.grayColor,
      secondary: AppColors.yellowColor,
      onSecondary: AppColors.fiordColor,
      error: AppColors.redColor,
      onError: AppColors.grayColor,
      background: AppColors.grayColor,
      onBackground: AppColors.fiordColor,
      surface: AppColors.grayColor,
      onSurface: AppColors.fiordColor);

  static const ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkColor,
      onPrimary: AppColors.yellowColor,
      secondary: AppColors.grayColor,
      onSecondary: AppColors.darkColor,
      error: AppColors.redColor,
      onError: AppColors.darkColor,
      background: AppColors.darkColor,
      onBackground: AppColors.yellowColor,
      surface: AppColors.darkColor,
      onSurface: AppColors.darkColor);
}
