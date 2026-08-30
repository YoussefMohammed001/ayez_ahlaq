import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import 'package:ayez_ahlaq/core/helpers/user_helpers.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorage(this._secureStorage);

  Future<void> write(SecureStorageKeys key, String value) async {
    await _secureStorage.write(key: key.name, value: value);
  }

  Future<void> writeRaw(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> read(SecureStorageKeys key) async {
    return await _secureStorage.read(key: key.name);
  }

  Future<String?> readRaw(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<bool> containsKey(SecureStorageKeys key) async {
    final value = await _secureStorage.read(key: key.name);
    return value != null;
  }

  Future<void> delete(SecureStorageKeys key) async {
    await _secureStorage.delete(key: key.name);
  }

  Future<void> deleteRaw(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  Future<Map<String, String>> getAll() async {
    return await _secureStorage.readAll();
  }

  Future<void> clearOnFreshInstall(
    SecureStorage storage,
    PreferencesStorage preferencesStorage,
  ) async {
    if (UserHelpers.isFirstTime()) {
      safePrint("clear all secure storage");
      await storage.deleteAll();
      await preferencesStorage.putBoolean(
        key: PreferencesKeys.firstOpen,
        value: false,
      );
    }
  }
}

enum SecureStorageKeys {
  userToken,
  localAuthEnabled,
  appLanguage,
  themeMode,
  phoneNumber,
  password,
  countryCode,
  countryDialCode,
}
