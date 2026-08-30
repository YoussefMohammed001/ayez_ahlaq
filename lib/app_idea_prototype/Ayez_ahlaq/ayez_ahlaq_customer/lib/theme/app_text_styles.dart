import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Display face is Reem Kufi (bold geometric, used for logo/headings),
/// body/UI face is Cairo. Both support Arabic well.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle displayH1 = GoogleFonts.reemKufi(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.ivory100,
    height: 1.25,
  );

  static TextStyle headingH2 = GoogleFonts.reemKufi(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    color: AppColors.ivory100,
  );

  static TextStyle headingH3 = GoogleFonts.cairo(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.ivory100,
  );

  static TextStyle bodyLarge = GoogleFonts.cairo(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.ivory100,
    height: 1.6,
  );

  static TextStyle bodyMedium = GoogleFonts.cairo(
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
    color: AppColors.ivory500,
    height: 1.6,
  );

  static TextStyle bodySmall = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.ivory500,
  );

  static TextStyle labelButton = GoogleFonts.cairo(
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static TextStyle caption = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.ivory700,
  );
}
