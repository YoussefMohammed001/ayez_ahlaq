import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_outcome.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_zone.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/geofence_transition.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/presence_action.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/presence_fix.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/shop_presence_monitor.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/repos/i_presence_tracker.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/handle_geofence_transition_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/track_shop_presence_use_case.dart';
import 'auto_attendance_test_doubles.dart';

const _shopLat = 30.0;
const _shopLng = 31.0;
const _metersPerDegree = 111195.0;

const _zone = AutoAttendanceZone(
  latitude: _shopLat,
  longitude: _shopLng,
  radiusMeters: 100,
  trackedRangeMeters: 5,
);

PresenceFix _fix(double metersNorth, {double accuracy = 3}) => PresenceFix(
  latitude: _shopLat + metersNorth / _metersPerDegree,
  longitude: _shopLng,
  accuracyMeters: accuracy,
);

const _tinyRangeConfig = AttendanceConfig(
  shopLat: _shopLat,
  shopLng: _shopLng,
  rangeMeters: 5,
  enforced: true,
);

class _Tracker implements IPresenceTracker {
  final List<PresenceFix> script;
  _Tracker(this.script);

  @override
  Stream<PresenceFix> fixes() => Stream.fromIterable(script);
}

void main() {
  group('monitor', () {
    ShopPresenceMonitor monitor({bool onShift = false}) =>
        ShopPresenceMonitor(zone: _zone, onShift: onShift);

    test('checks in after two fixes inside the range', () {
      final m = monitor();

      expect(m.onFix(_fix(3)), PresenceAction.none);
      expect(m.onFix(_fix(2)), PresenceAction.checkIn);
      expect(m.onShift, isTrue);
    });

    test('one stray fix inside the range is not enough', () {
      final m = monitor();

      expect(m.onFix(_fix(3)), PresenceAction.none);
      expect(m.onFix(_fix(40)), PresenceAction.none);
      expect(m.onFix(_fix(3)), PresenceAction.none);
    });

    test('stays out while walking in the ring but outside the range', () {
      final m = monitor();

      for (final meters in [90.0, 60.0, 30.0, 12.0, 8.0]) {
        expect(m.onFix(_fix(meters)), PresenceAction.none);
      }
    });

    test('checks out after two fixes clearly outside the range', () {
      final m = monitor(onShift: true);

      expect(m.onFix(_fix(20)), PresenceAction.none);
      expect(m.onFix(_fix(25)), PresenceAction.checkOut);
      expect(m.onShift, isFalse);
    });

    test('a fix near the border does not check out because of the error', () {
      final m = monitor(onShift: true);

      for (var i = 0; i < 5; i++) {
        expect(m.onFix(_fix(7, accuracy: 4)), PresenceAction.none);
      }
    });

    test('ignores fixes that are too inaccurate', () {
      final m = monitor();

      for (var i = 0; i < 4; i++) {
        expect(m.onFix(_fix(1, accuracy: 80)), PresenceAction.none);
      }
    });

    test('reports leaving the ring', () {
      expect(monitor(onShift: true).onFix(_fix(250)), PresenceAction.leftZone);
    });

    test('undo restores the shift state after a failed call', () {
      final m = monitor();
      m.onFix(_fix(1));
      final action = m.onFix(_fix(1));

      m.undo(action);

      expect(m.onShift, isFalse);
      expect(m.onFix(_fix(1)), PresenceAction.none);
    });
  });

  group('tracking use case', () {
    late FakeAttendanceRepo repo;
    late FakeStore store;
    late DateTime now;
    late List<AutoAttendanceOutcome> outcomes;

    setUp(() {
      repo = FakeAttendanceRepo()
        ..current = const Right(
          CurrentAttendance(shift: null, config: _tinyRangeConfig),
        );
      store = FakeStore();
      now = DateTime(2026, 11, 8, 9);
      outcomes = [];
    });

    Future<void> track(List<PresenceFix> script) => TrackShopPresenceUseCase(
      GetCurrentAttendanceUseCase(repo),
      CheckInAttendanceUseCase(repo),
      CheckOutAttendanceUseCase(repo),
      store,
      _Tracker(script),
      () => now,
    )(outcomes.add);

    test('walks in, checks in, walks out of the range, checks out', () async {
      await track([
        _fix(80),
        _fix(20),
        _fix(3),
        _fix(2),
        _fix(30),
        _fix(35),
        _fix(250),
      ]);

      expect(repo.calls, ['in', 'out']);
      expect(outcomes, [
        AutoAttendanceOutcome.checkedIn,
        AutoAttendanceOutcome.checkedOut,
      ]);
    });

    test('sends the real position and the auto method', () async {
      await track([_fix(2), _fix(2)]);

      expect(repo.lastLat, closeTo(_shopLat, 0.0001));
      expect(repo.lastMethod?.name, 'auto');
    });

    test('leaving the ring on shift checks out once', () async {
      repo.current = Right(
        CurrentAttendance(shift: openShift(), config: _tinyRangeConfig),
      );

      await track([_fix(2), _fix(300)]);

      expect(repo.calls, ['out']);
    });

    test('leaving the ring off shift does nothing', () async {
      await track([_fix(60), _fix(300)]);

      expect(repo.calls, isEmpty);
    });

    test('a rejected check in is reported and tried again later', () async {
      repo.checkInResult = Left(Failure('far', 400, const {}));

      await track([_fix(2), _fix(2), _fix(2), _fix(2)]);

      expect(repo.calls, ['in', 'in']);
      expect(outcomes, [
        AutoAttendanceOutcome.failed,
        AutoAttendanceOutcome.failed,
      ]);
    });

    test('does not start when another session is alive', () async {
      store.trackingHeartbeat = now.subtract(const Duration(seconds: 20));

      await track([_fix(2), _fix(2)]);

      expect(repo.calls, isEmpty);
    });

    test('takes over from a session that stopped beating', () async {
      store.trackingHeartbeat = now.subtract(const Duration(minutes: 10));

      await track([_fix(2), _fix(2)]);

      expect(repo.calls, ['in']);
    });

    test('clears its heartbeat when it ends', () async {
      await track([_fix(2)]);

      expect(store.trackingHeartbeat, isNull);
    });

    test('stops once the feature is switched off', () async {
      store.enabled = false;

      await track([_fix(2), _fix(2)]);

      expect(repo.calls, isEmpty);
    });

    test('does nothing for a range that needs no tracking', () async {
      repo.current = const Right(
        CurrentAttendance(
          shift: null,
          config: AttendanceConfig(
            shopLat: _shopLat,
            shopLng: _shopLng,
            rangeMeters: 300,
            enforced: true,
          ),
        ),
      );

      await track([_fix(2), _fix(2)]);

      expect(repo.calls, isEmpty);
    });
  });

  group('entering a tracked zone', () {
    test('asks for tracking instead of checking in at the ring', () async {
      final repo = FakeAttendanceRepo()
        ..current = const Right(
          CurrentAttendance(shift: null, config: _tinyRangeConfig),
        );
      final handler = HandleGeofenceTransitionUseCase(
        GetCurrentAttendanceUseCase(repo),
        CheckInAttendanceUseCase(repo),
        CheckOutAttendanceUseCase(repo),
        FakeStore(),
        FakeRegistrar(),
      );

      final outcome = await handler(
        GeofenceTransition.entered,
        lat: 30.0009,
        lng: 31,
      );

      expect(outcome, AutoAttendanceOutcome.needsTracking);
      expect(repo.calls, isEmpty);
    });
  });
}
