import 'package:flutter/material.dart';

/// Barbershop palette: warm ink + brass. Kept as a flat token list so
/// screens never hardcode a hex value directly.
class AppColors {
  AppColors._();

  static const ink950 = Color(0xFF14120F);
  static const ink900 = Color(0xFF1C1916);
  static const ink800 = Color(0xFF262119);
  static const ink750 = Color(0xFF2C2620);
  static const ink700 = Color(0xFF372F24);

  static const hairline = Color(0xFF3C3327);

  static const brass100 = Color(0xFF3A331F);
  static const brass300 = Color(0xFFE3C273);
  static const brass400 = Color(0xFFD9AE49);
  static const brass500 = Color(0xFFC6982F);
  static const brass600 = Color(0xFFA97F26);
  static const brass700 = Color(0xFF8F6C1F);

  static const ivory100 = Color(0xFFF3ECDD);
  static const ivory300 = Color(0xFFC9BFA8);
  static const ivory500 = Color(0xFF8C8270);
  static const ivory700 = Color(0xFF655D4E);

  static const moss500 = Color(0xFF7CA37C);
  static const moss600 = Color(0xFF5C8560);

  static const rust400 = Color(0xFFD97355);
  static const rust500 = Color(0xFFC1573B);
}
