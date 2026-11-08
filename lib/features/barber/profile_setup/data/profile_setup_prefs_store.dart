import '../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../domain/repos/i_profile_setup_store.dart';

class ProfileSetupPrefsStore implements IProfileSetupStore {
  final PreferencesStorage _preferences;

  ProfileSetupPrefsStore(this._preferences);

  @override
  bool get started =>
      _preferences.getBoolean(key: PreferencesKeys.profileSetupStarted);

  @override
  bool get dismissed =>
      _preferences.getBoolean(key: PreferencesKeys.profileSetupDismissed);

  @override
  Future<void> markStarted() => _preferences.putBoolean(
    key: PreferencesKeys.profileSetupStarted,
    value: true,
  );

  @override
  Future<void> dismiss() => _preferences.putBoolean(
    key: PreferencesKeys.profileSetupDismissed,
    value: true,
  );
}
