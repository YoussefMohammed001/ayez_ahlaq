import 'dart:developer';
import 'dart:io';
import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../domain/use_cases/register_device_token_use_case.dart';
import '../../domain/use_cases/unregister_all_device_tokens_use_case.dart';

class MerchantDeviceTokenSyncService {
  final RegisterDeviceTokenUseCase _register;
  final UnregisterAllDeviceTokensUseCase _unregisterAll;
  final PreferencesStorage _preferences;

  MerchantDeviceTokenSyncService(
    this._register,
    this._unregisterAll,
    this._preferences,
  );

  String get _platform => Platform.isIOS ? 'IOS' : 'ANDROID';

  Future<void> syncToken(String token) async {
    final previousToken = _preferences.getString(key: PreferencesKeys.fcmToken);
    if (previousToken == token) return;

    final result = await _register(token, _platform);

    result.fold(
      (failure) => log('Device token register failed: ${failure.message}'),
      (_) => _preferences.putString(
        key: PreferencesKeys.fcmToken,
        value: token,
      ),
    );
  }

  Future<void> unregisterAllTokens() async {
    await _unregisterAll();
    await _preferences.putString(key: PreferencesKeys.fcmToken, value: '');
  }
}
