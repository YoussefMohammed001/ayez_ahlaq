import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../../../../core/constants/strings.dart';
import '../../domain/repos/i_auto_attendance_store.dart';

class AutoAttendancePrefsStore implements IAutoAttendanceStore {
  final PreferencesStorage _preferences;

  AutoAttendancePrefsStore(this._preferences);

  @override
  bool get isEnabled =>
      _preferences.getBoolean(key: PreferencesKeys.autoAttendanceEnabled);

  String get serverUrl =>
      _preferences.getString(key: PreferencesKeys.autoAttendanceBaseUrl);

  @override
  Future<void> setEnabled(bool value) async {
    await _preferences.putBoolean(
      key: PreferencesKeys.autoAttendanceEnabled,
      value: value,
    );
    await _preferences.putString(
      key: PreferencesKeys.autoAttendanceBaseUrl,
      value: value ? AppStrings.baseUrl : null,
    );
  }
}
