import '../../../attendance/domain/entities/attendance_config.dart';
import 'auto_attendance_eligibility.dart';
import 'auto_attendance_zone.dart';

class AutoAttendancePolicy {
  const AutoAttendancePolicy._();

  static const double minRadiusMeters = 100;
  static const double defaultRadiusMeters = 150;
  static const double enforcedRadiusFactor = 0.8;

  static double get trackedBelowRangeMeters =>
      minRadiusMeters / enforcedRadiusFactor;

  static AutoAttendanceEligibility eligibilityOf(AttendanceConfig config) {
    if (config.shopLat == null || config.shopLng == null) {
      return AutoAttendanceEligibility.noShopLocation;
    }

    return AutoAttendanceEligibility.eligible;
  }

  static AutoAttendanceZone? zoneOf(AttendanceConfig config) {
    if (eligibilityOf(config) != AutoAttendanceEligibility.eligible) {
      return null;
    }

    final range = config.rangeMeters?.toDouble();
    final tracked =
        config.enforced && range != null && range < trackedBelowRangeMeters;

    if (tracked) {
      return AutoAttendanceZone(
        latitude: config.shopLat!,
        longitude: config.shopLng!,
        radiusMeters: minRadiusMeters,
        trackedRangeMeters: range,
      );
    }

    final radius = config.enforced
        ? (range ?? minRadiusMeters / enforcedRadiusFactor) *
              enforcedRadiusFactor
        : (range ?? defaultRadiusMeters).clamp(
            minRadiusMeters,
            double.infinity,
          );

    return AutoAttendanceZone(
      latitude: config.shopLat!,
      longitude: config.shopLng!,
      radiusMeters: radius,
    );
  }
}
