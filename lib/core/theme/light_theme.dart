import 'package:flutter/material.dart';
import 'app_semantic_colors.dart';
import '/core/constants/strings.dart';
import '/core/theme/light_colors.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppLightColors.brass500,
  onPrimary: AppLightColors.white,
  primaryContainer: AppLightColors.brass100,
  onPrimaryContainer: AppLightColors.brass700,
  secondary: AppLightColors.brass300,
  onSecondary: AppLightColors.white,
  tertiary: AppLightColors.sky500,
  onTertiary: AppLightColors.white,
  surface: AppLightColors.surface,
  onSurface: AppLightColors.ink900,
  surfaceContainerLowest: AppLightColors.sand50,
  surfaceContainer: AppLightColors.sand100,
  surfaceContainerHigh: AppLightColors.sand200,
  surfaceContainerHighest: AppLightColors.sand300,
  onSurfaceVariant: AppLightColors.ink700,
  outline: AppLightColors.hairline,
  outlineVariant: AppLightColors.sand300,
  error: AppLightColors.rust500,
  onError: AppLightColors.white,
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  extensions: const [AppSemanticColors.light],
  colorScheme: lightColorScheme,
  fontFamily: AppStrings.fontFamily,
  scaffoldBackgroundColor: AppLightColors.sand50,
  canvasColor: AppLightColors.surface,
  dividerColor: AppLightColors.hairline,
  hintColor: AppLightColors.ink500,
  dividerTheme: const DividerThemeData(
    color: AppLightColors.hairline,
    thickness: 1,
    space: 1,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppLightColors.sand50,
    foregroundColor: AppLightColors.ink900,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: AppStrings.headingFontFamily,
      color: AppLightColors.ink900,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
  ),
  cardTheme: const CardThemeData(
    color: AppLightColors.sand100,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppLightColors.surface,
    selectedItemColor: AppLightColors.brass500,
    unselectedItemColor: AppLightColors.ink500,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppLightColors.surface,
    surfaceTintColor: Colors.transparent,
    showDragHandle: true,
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: AppLightColors.surface,
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppLightColors.sand100,
    hintStyle: TextStyle(color: AppLightColors.ink500),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppLightColors.hairline),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppLightColors.hairline),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppLightColors.brass500),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppLightColors.rust500),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppLightColors.brass500,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppLightColors.ink900,
    contentTextStyle: TextStyle(color: AppLightColors.white),
  ),
);
