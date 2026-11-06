import '../../../attendance/domain/entities/attendance_config.dart';
import 'auto_attendance_eligibility.dart';
import 'auto_attendance_zone.dart';

class AutoAttendancePolicy {
  const AutoAttendancePolicy._();

  static const double minRadiusMeters = 100;
  static const double defaultRadiusMeters = 150;
  static const double enforcedRadiusFactor = 0.8;
  static const Duration duplicateWindow = Duration(minutes: 2);

  static double get minEnforcedRangeMeters =>
      minRadiusMeters / enforcedRadiusFactor;

  static AutoAttendanceEligibility eligibilityOf(AttendanceConfig config) {
    if (config.shopLat == null || config.shopLng == null) {
      return AutoAttendanceEligibility.noShopLocation;
    }

    final range = config.rangeMeters;
    if (config.enforced && (range ?? 0) < minEnforcedRangeMeters) {
      return AutoAttendanceEligibility.rangeTooSmall;
    }

    return AutoAttendanceEligibility.eligible;
  }

  static AutoAttendanceZone? zoneOf(AttendanceConfig config) {
    if (eligibilityOf(config) != AutoAttendanceEligibility.eligible) {
      return null;
    }

    final range = config.rangeMeters?.toDouble();
    final radius = config.enforced
        ? range! * enforcedRadiusFactor
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
