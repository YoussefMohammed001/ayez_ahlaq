import 'package:flutter/material.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class UpdateAppState extends AppState {}

class NoInternetState extends AppState {}

class ThemeChangedState extends AppState {
  final ThemeMode themeMode;
  ThemeChangedState(this.themeMode);
}

class LanguageChangedState extends AppState {
  final String language;
  LanguageChangedState(this.language);
}

class AdminApprovalGranted extends AppState {}
