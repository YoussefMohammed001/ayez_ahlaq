import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.ink900,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.brass500,
        secondary: AppColors.brass400,
        surface: AppColors.ink800,
        error: AppColors.rust500,
      ),
      textTheme: GoogleFonts.cairoTextTheme(base.textTheme).apply(
        bodyColor: AppColors.ivory100,
        displayColor: AppColors.ivory100,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ink900,
        elevation: 0,
        centerTitle: true,
      ),
      dividerColor: AppColors.hairline,
      splashFactory: InkRipple.splashFactory,
    );
  }
}
