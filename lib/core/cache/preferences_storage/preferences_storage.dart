import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'preferences_storage_keys.dart';

class PreferencesStorage {
  final SharedPreferences _preferences;

  PreferencesStorage(this._preferences);

  Future<void> clear() async {
    await _preferences.clear();
  }

  Future<void> putBoolean({
    required PreferencesKeys key,
    required bool value,
  }) async {
    await _preferences.setBool(key.name, value);
  }

  bool getBoolean({required PreferencesKeys key, bool defaultValue = false}) {
    return _preferences.getBool(key.name) ?? defaultValue;
  }

  Future<bool> putString({
    required PreferencesKeys key,
    required String? value,
  }) async {
    return await _preferences.setString(key.name, value ?? "");
  }

  String getString({required PreferencesKeys key}) {
    return _preferences.getString(key.name) ?? "";
  }

  Future<bool> putInt({
    required PreferencesKeys key,
    required int value,
  }) async {
    return await _preferences.setInt(key.name, value);
  }

  int getInt({required PreferencesKeys key, int defaultValue = 0}) {
    return _preferences.getInt(key.name) ?? defaultValue;
  }

  Future<bool> putStringList({
    required PreferencesKeys key,
    required List<String> value,
  }) async {
    return await _preferences.setStringList(key.name, value);
  }

  List<String> getStringList({required PreferencesKeys key}) {
    return _preferences.getStringList(key.name) ?? [];
  }

  dynamic getJson({required PreferencesKeys key}) {
    final raw = _preferences.getString(key.name);

    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    try {
      return jsonDecode(raw);
    } catch (e) {
      return null;
    }
  }

  Future<bool> putJson({
    required PreferencesKeys key,
    required dynamic value,
  }) async {
    try {
      final jsonString = jsonEncode(value);
      return await _preferences.setString(key.name, jsonString);
    } catch (e) {
      return false;
    }
  }

  String getCurrentLanguage() {
    return _preferences.getString(PreferencesKeys.currentLanguage.name) ?? "ar";
  }

  bool isEnglish() => getCurrentLanguage() == "en";
  bool isArabic() => getCurrentLanguage() == "ar";

  int getUserId() {
    return _preferences.getInt(PreferencesKeys.userId.name) ?? 0;
  }

  Future<bool> putUserId(int userId) async {
    return await _preferences.setInt(PreferencesKeys.userId.name, userId);
  }
}
