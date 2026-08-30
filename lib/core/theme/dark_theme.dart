import 'package:flutter/material.dart';
import 'app_semantic_colors.dart';
import '/core/constants/strings.dart';
import '/core/theme/dark_colors.dart';

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppDarkColors.brass500,
  onPrimary: AppDarkColors.ink950,
  primaryContainer: AppDarkColors.brass100,
  onPrimaryContainer: AppDarkColors.brass300,
  secondary: AppDarkColors.brass300,
  onSecondary: AppDarkColors.ink950,
  tertiary: AppDarkColors.sky500,
  onTertiary: AppDarkColors.ink950,
  surface: AppDarkColors.ink900,
  onSurface: AppDarkColors.ivory100,
  surfaceContainerLowest: AppDarkColors.ink950,
  surfaceContainer: AppDarkColors.ink800,
  surfaceContainerHigh: AppDarkColors.ink750,
  surfaceContainerHighest: AppDarkColors.ink700,
  onSurfaceVariant: AppDarkColors.ivory300,
  outline: AppDarkColors.hairline,
  outlineVariant: AppDarkColors.ink700,
  error: AppDarkColors.rust500,
  onError: AppDarkColors.ivory100,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  extensions: const [AppSemanticColors.dark],
  colorScheme: darkColorScheme,
  fontFamily: AppStrings.fontFamily,
  scaffoldBackgroundColor: AppDarkColors.ink950,
  canvasColor: AppDarkColors.ink900,
  dividerColor: AppDarkColors.hairline,
  hintColor: AppDarkColors.ivory500,
  dividerTheme: const DividerThemeData(
    color: AppDarkColors.hairline,
    thickness: 1,
    space: 1,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppDarkColors.ink900,
    foregroundColor: AppDarkColors.ivory100,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: AppStrings.headingFontFamily,
      color: AppDarkColors.ivory100,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
  ),
  cardTheme: const CardThemeData(
    color: AppDarkColors.ink800,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppDarkColors.ink900,
    selectedItemColor: AppDarkColors.brass500,
    unselectedItemColor: AppDarkColors.ivory500,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppDarkColors.ink900,
    surfaceTintColor: Colors.transparent,
    showDragHandle: true,
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: AppDarkColors.ink800,
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppDarkColors.ink700,
    hintStyle: TextStyle(color: AppDarkColors.ivory500),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppDarkColors.hairline),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppDarkColors.hairline),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppDarkColors.brass500),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppDarkColors.rust500),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppDarkColors.brass500,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppDarkColors.ink800,
    contentTextStyle: TextStyle(color: AppDarkColors.ivory100),
  ),
);
