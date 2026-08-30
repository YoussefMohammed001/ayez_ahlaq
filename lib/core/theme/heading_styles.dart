import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/strings.dart';

class HeadingStyles {
  static const String _family = AppStrings.headingFontFamily;

  static TextStyle get h1 => TextStyle(
    fontFamily: _family,
    fontWeight: FontWeight.w700,
    fontSize: 23.sp,
  );

  static TextStyle get h2 => TextStyle(
    fontFamily: _family,
    fontWeight: FontWeight.w700,
    fontSize: 21.sp,
  );

  static TextStyle get h3 => TextStyle(
    fontFamily: _family,
    fontWeight: FontWeight.w700,
    fontSize: 19.sp,
  );

  static TextStyle get h4 => TextStyle(
    fontFamily: _family,
    fontWeight: FontWeight.w700,
    fontSize: 17.sp,
  );

  static TextStyle get h5 => TextStyle(
    fontFamily: _family,
    fontWeight: FontWeight.w700,
    fontSize: 15.sp,
  );
}
