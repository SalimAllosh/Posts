import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posts_app/Core/Colors/app_colors.dart';

class AppTextStyles {
  static final TextStyle displayLargeTextStyle =
      GoogleFonts.robotoSlab(fontSize: 30, color: AppColors.fiordColor);
  static final TextStyle displayMediumTextStyle = GoogleFonts.courgette(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.fiordColor);
  static final TextStyle displaySmallTextStyle =
      GoogleFonts.courgette(fontSize: 15, color: AppColors.fiordColor);

  static final TextStyle displayLargeTextStyleGray =
      GoogleFonts.robotoSlab(fontSize: 30, color: AppColors.grayColor);
  static final TextStyle displayMediumTextStyleGray = GoogleFonts.courgette(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.grayColor);
  static final TextStyle displaySmallTextStyleGray =
      GoogleFonts.courgette(fontSize: 15, color: AppColors.grayColor);
}
