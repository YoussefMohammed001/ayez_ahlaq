import 'package:flutter/material.dart';
import 'dark_colors.dart';
import 'light_colors.dart';

class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  final Color success;
  final Color info;
  final Color warning;
  final Color accentSoft;
  final Color accentStrong;
  final Color onAccent;

  const AppSemanticColors({
    required this.success,
    required this.info,
    required this.warning,
    required this.accentSoft,
    required this.accentStrong,
    required this.onAccent,
  });

  static const dark = AppSemanticColors(
    success: AppDarkColors.moss500,
    info: AppDarkColors.sky400,
    warning: AppDarkColors.rust400,
    accentSoft: AppDarkColors.brass300,
    accentStrong: AppDarkColors.brass400,
    onAccent: AppDarkColors.ink950,
  );

  static const light = AppSemanticColors(
    success: AppLightColors.moss500,
    info: AppLightColors.sky500,
    warning: AppLightColors.rust500,
    accentSoft: AppLightColors.brass500,
    accentStrong: AppLightColors.brass600,
    onAccent: AppLightColors.white,
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? info,
    Color? warning,
    Color? accentSoft,
    Color? accentStrong,
    Color? onAccent,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      accentSoft: accentSoft ?? this.accentSoft,
      accentStrong: accentStrong ?? this.accentStrong,
      onAccent: onAccent ?? this.onAccent,
    );
  }

  @override
  AppSemanticColors lerp(AppSemanticColors? other, double t) {
    if (other == null) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      info: Color.lerp(info, other.info, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      accentStrong: Color.lerp(accentStrong, other.accentStrong, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
    );
  }
}
