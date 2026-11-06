import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../../../../core/constants/strings.dart';
import '../../domain/entities/geofence_transition.dart';
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

  @override
  DateTime? lastEventAt(GeofenceTransition transition) {
    final raw = _preferences.getString(key: _keyOf(transition));
    return raw.isEmpty ? null : DateTime.tryParse(raw);
  }

  @override
  Future<void> saveLastEvent(GeofenceTransition transition, DateTime at) async {
    await _preferences.putString(
      key: _keyOf(transition),
      value: at.toIso8601String(),
    );
  }

  PreferencesKeys _keyOf(GeofenceTransition transition) => switch (transition) {
    GeofenceTransition.entered => PreferencesKeys.autoAttendanceLastEntered,
    GeofenceTransition.exited => PreferencesKeys.autoAttendanceLastExited,
  };
}
