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

    test('a small range is fine when attendance is not enforced', () {
      expect(
        AutoAttendancePolicy.eligibilityOf(_config(range: 20)),
        AutoAttendanceEligibility.eligible,
      );
    });
  });

  group('zone', () {
    test('is null when the shop has no location', () {
      expect(AutoAttendancePolicy.zoneOf(_config(lat: null)), isNull);
    });

    test('a small enforced range is tracked inside the minimum ring', () {
      expect(AutoAttendancePolicy.trackedBelowRangeMeters, 125);

      for (final range in [5, 50, 124]) {
        final zone = AutoAttendancePolicy.zoneOf(
          _config(range: range, enforced: true),
        )!;

        expect(zone.needsTracking, isTrue, reason: '$range');
        expect(zone.radiusMeters, 100);
        expect(zone.trackedRangeMeters, range.toDouble());
      }
    });

    test('an enforced range from 125 up is not tracked', () {
      final zone = AutoAttendancePolicy.zoneOf(
        _config(range: 125, enforced: true),
      )!;

      expect(zone.needsTracking, isFalse);
      expect(zone.radiusMeters, 100);
    });

    test('a small range is not tracked when attendance is not enforced', () {
      expect(
        AutoAttendancePolicy.zoneOf(_config(range: 5))!.needsTracking,
        isFalse,
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
