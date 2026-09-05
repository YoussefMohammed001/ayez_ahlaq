import 'dart:developer';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../domain/use_cases/register_customer_device_token_use_case.dart';
import '../../domain/use_cases/unregister_all_customer_device_tokens_use_case.dart';

class CustomerDeviceTokenSyncService {
  final RegisterCustomerDeviceTokenUseCase _register;
  final UnregisterAllCustomerDeviceTokensUseCase _unregisterAll;
  final PreferencesStorage _preferences;

  CustomerDeviceTokenSyncService(
    this._register,
    this._unregisterAll,
    this._preferences,
  );

  String get _platform => Platform.isIOS ? 'IOS' : 'ANDROID';

  Future<void> syncToken(String token) async {
    final previousToken = _preferences.getString(key: PreferencesKeys.fcmToken);
    if (previousToken == token) return;

    final position = await _resolveCurrentPosition();

    final result = await _register(
      token,
      _platform,
      lat: position?.latitude,
      lng: position?.longitude,
    );

    result.fold(
      (failure) => log('Device token register failed: ${failure.message}'),
      (_) => _preferences.putString(key: PreferencesKeys.fcmToken, value: token),
    );
  }

  Future<Position?> _resolveCurrentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }

  Future<void> unregisterAllTokens() async {
    await _unregisterAll();
    await _preferences.putString(key: PreferencesKeys.fcmToken, value: '');
  }
}
