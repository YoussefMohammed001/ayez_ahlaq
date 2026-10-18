import '../../core/analytics/analytics_params.dart';
import '../../core/analytics/i_analytics_service.dart';
import '../../core/cache/preferences_storage/preferences_storage.dart';
import '../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../location/domain/use_cases/get_current_location_use_case.dart';
import '../location/domain/use_cases/resolve_governorate_use_case.dart';
import '../user_type.dart';

class UserAnalyticsSync {
  final IAnalyticsService _analytics;
  final PreferencesStorage _preferences;
  final GetCurrentLocationUseCase _getCurrentLocation;
  final ResolveGovernorateUseCase _resolveGovernorate;

  UserAnalyticsSync(
    this._analytics,
    this._preferences,
    this._getCurrentLocation,
    this._resolveGovernorate,
  );

  Future<void> identify(UserType type, {int? userId}) async {
    await _analytics.setUserProperty(
      AnalyticsUserProperties.userType,
      type.apiSegment,
    );
    if (userId != null)
      await _analytics.setUserId('${type.apiSegment}_$userId');
    await syncGovernorate();
  }

  Future<void> clear() async {
    await _analytics.setUserId(null);
    await _analytics.setUserProperty(AnalyticsUserProperties.userType, null);
  }

  Future<void> syncGovernorate() async {
    final stored = _preferences.getString(key: PreferencesKeys.governorate);
    if (stored.isNotEmpty) {
      await _analytics.setUserProperty(
        AnalyticsUserProperties.governorate,
        stored,
      );
    }

    final result = await _getCurrentLocation(requestPermission: false);
    final point = result.point;
    if (point == null) return;

    final governorate = await _resolveGovernorate(point);
    if (governorate == null || governorate.isEmpty) return;

    await _preferences.putString(
      key: PreferencesKeys.governorate,
      value: governorate,
    );
    await _analytics.setUserProperty(
      AnalyticsUserProperties.governorate,
      governorate,
    );
  }
}
