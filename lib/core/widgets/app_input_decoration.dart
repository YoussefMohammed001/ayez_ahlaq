import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/ext_theme.dart';

class AppInputDecoration {
  static InputDecoration build(BuildContext context, String hint) {
    final scheme = context.colorScheme;

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: scheme.outlineVariant,
        fontSize: 13.sp,
      ),
      filled: true,
      fillColor: scheme.surfaceContainer,
      border: _border(scheme.outline),
      enabledBorder: _border(scheme.outline),
      focusedBorder: _border(scheme.primary, width: 1.5),
      errorBorder: _border(scheme.error),
      focusedErrorBorder: _border(scheme.error),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    );
  }

  static OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
