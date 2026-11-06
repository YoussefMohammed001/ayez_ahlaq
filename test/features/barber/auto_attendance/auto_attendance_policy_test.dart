import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_eligibility.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_policy.dart';

AttendanceConfig _config({
  double? lat = 30.0,
  double? lng = 31.0,
  int? range,
  bool enforced = false,
}) => AttendanceConfig(
  shopLat: lat,
  shopLng: lng,
  rangeMeters: range,
  enforced: enforced,
);

void main() {
  group('eligibility', () {
    test('needs the shop location', () {
      expect(
        AutoAttendancePolicy.eligibilityOf(_config(lat: null)),
        AutoAttendanceEligibility.noShopLocation,
      );
      expect(
        AutoAttendancePolicy.eligibilityOf(_config(lng: null)),
        AutoAttendanceEligibility.noShopLocation,
      );
    });

    test('an enforced range below the minimum is too small', () {
      expect(AutoAttendancePolicy.minEnforcedRangeMeters, 125);
      expect(
        AutoAttendancePolicy.eligibilityOf(_config(range: 124, enforced: true)),
        AutoAttendanceEligibility.rangeTooSmall,
      );
      expect(
        AutoAttendancePolicy.eligibilityOf(_config(range: 125, enforced: true)),
        AutoAttendanceEligibility.eligible,
      );
    });

    test('an enforced config without a range is too small', () {
      expect(
        AutoAttendancePolicy.eligibilityOf(_config(enforced: true)),
        AutoAttendanceEligibility.rangeTooSmall,
      );
    });

    test('a small range is fine when attendance is not enforced', () {
      expect(
        AutoAttendancePolicy.eligibilityOf(_config(range: 20)),
        AutoAttendanceEligibility.eligible,
      );
    });
  });

  group('zone', () {
    test('is null when the config is not eligible', () {
      expect(AutoAttendancePolicy.zoneOf(_config(lat: null)), isNull);
      expect(
        AutoAttendancePolicy.zoneOf(_config(range: 50, enforced: true)),
        isNull,
      );
    });

    test(
      'shrinks an enforced range so entering is inside the server range',
      () {
        final zone = AutoAttendancePolicy.zoneOf(
          _config(range: 200, enforced: true),
        )!;

        expect(zone.radiusMeters, 160);
        expect(zone.latitude, 30.0);
        expect(zone.longitude, 31.0);
      },
    );

    test('never goes below the native minimum when not enforced', () {
      expect(
        AutoAttendancePolicy.zoneOf(_config(range: 30))!.radiusMeters,
        100,
      );
      expect(
        AutoAttendancePolicy.zoneOf(_config(range: 400))!.radiusMeters,
        400,
      );
    });

    test('falls back to the default radius when there is no range', () {
      expect(
        AutoAttendancePolicy.zoneOf(_config())!.radiusMeters,
        AutoAttendancePolicy.defaultRadiusMeters,
      );
    });
  });
}
