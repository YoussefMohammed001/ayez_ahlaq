import '../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../../../core/cache/secure_storage/secure_storage.dart';
import '../../domain/entities/auth_session.dart';

class AuthLocalDataSource {
  final SecureStorage _secureStorage;
  final PreferencesStorage _preferencesStorage;

  AuthLocalDataSource(this._secureStorage, this._preferencesStorage);

  Future<void> saveSession(AuthSession session, String phone) async {
    await _secureStorage.write(SecureStorageKeys.userToken, session.token);
    await _preferencesStorage.putInt(
      key: PreferencesKeys.userId,
      value: session.actorId,
    );
    await _preferencesStorage.putString(
      key: PreferencesKeys.phone,
      value: phone,
    );
    await _preferencesStorage.putString(
      key: PreferencesKeys.name,
      value: session.displayName,
    );
  }

  Future<void> clearSession() async {
    await _secureStorage.delete(SecureStorageKeys.userToken);
    await _preferencesStorage.putInt(key: PreferencesKeys.userId, value: 0);
    await _preferencesStorage.putString(key: PreferencesKeys.name, value: '');
  }
}
