import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '/core/di/services_locator.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    _initTheme();
  }

  StreamSubscription? _subscription;
  ThemeMode themeMode = ThemeMode.dark;
  bool isOffline = false;

  void _initTheme() {
    final saved = sl<PreferencesStorage>().getString(
      key: PreferencesKeys.themeMode,
    );
    themeMode = saved == 'light' ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeChangedState(themeMode));
  }

  Future<void> setTheme(ThemeMode mode) async {
    if (themeMode == mode) return;

    themeMode = mode;
    await sl<PreferencesStorage>().putString(
      key: PreferencesKeys.themeMode,
      value: mode == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(ThemeChangedState(mode));
  }

  void toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await sl<PreferencesStorage>().putString(
      key: PreferencesKeys.themeMode,
      value: themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(ThemeChangedState(themeMode));
  }

  void checkConnection() {
    Connectivity().checkConnectivity().then(_handleConnectivity);
    _subscription = Connectivity().onConnectivityChanged.listen(
      _handleConnectivity,
    );
  }

  void _handleConnectivity(List<ConnectivityResult> result) {
    final online = result.any(
      (e) => e == ConnectivityResult.wifi || e == ConnectivityResult.mobile,
    );
    if (online == !isOffline) return;
    isOffline = !online;
    emit(online ? UpdateAppState() : NoInternetState());
  }

  Future<void> changeLanguage() async {
    final saved = sl<PreferencesStorage>().getString(
      key: PreferencesKeys.currentLanguage,
    );

    final language = saved == 'ar' ? 'en' : 'ar';

    await sl<PreferencesStorage>().putString(
      key: PreferencesKeys.currentLanguage,
      value: language,
    );

    safePrint('Language changed to: $language');
    emit(LanguageChangedState(language));
  }

  Future<void> setLanguage(String language) async {
    final saved = sl<PreferencesStorage>().getString(
      key: PreferencesKeys.currentLanguage,
    );
    if (saved == language) return;

    await sl<PreferencesStorage>().putString(
      key: PreferencesKeys.currentLanguage,
      value: language,
    );

    safePrint('Language changed to: $language');
    emit(LanguageChangedState(language));
  }



  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
