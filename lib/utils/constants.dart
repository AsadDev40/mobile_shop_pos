// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final title1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold, // Medium
    fontSize: 26,
    color: AppColors.MainTextColor,
  );

  static final title2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold, // Bold
    fontSize: 24,
    color: AppColors.MainTextColor,
  );

  static final title3 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 22,
    color: AppColors.MainTextColor,
  );

  static final title4 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 20,
    color: AppColors.MainTextColor,
  );

  static final body1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 18,
    color: AppColors.BodyTextColor,
  );

  static final body2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 14,
    color: AppColors.BodyTextColor,
  );

  static final body3 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 13,
    color: AppColors.BodyTextColor,
  );
}

class AppColors {
  static const PrimaryColor = Color(0xFF4DC591);
  static const SecondaryColor = Color(0xFF9BA1FF);
  static const TertiaryColor = Color(0xFFFF7648);
  static const MainTextColor = Color(0xFF191B32);
  static const BodyTextColor = Color(0xFF9295A3);

  static const PrimaryGradient = LinearGradient(
    colors: [
      Color(0x80D8F7D3), // Lighter green with 50% transparency
      Color(0x80EBF9E9), // Very soft light green with 50% transparency
    ],
  );

  static const SecondaryGradient = LinearGradient(
    colors: [
      Color(0x80D6DFFF), // Very light blue with 50% transparency
      Color(0x80E7EFFF), // Lightest blue with 50% transparency
    ],
  );

  static const MixedGradient = LinearGradient(
    colors: [
      Color(0x80FFC1E2), // Lighter pink with 50% transparency
      Color(0x80FFE6F2), // Very light pink with 50% transparency
    ],
  );

  static const TertiaryGradient = LinearGradient(
    colors: [
      Color(0x80FFB2A5), // Soft light orange-pink with 50% transparency
      Color(0x80FFF0C9), // Very light yellow-orange with 50% transparency
    ],
  );
}
