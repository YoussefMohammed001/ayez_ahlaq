import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_method.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_outcome.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/background_location_status.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/enable_auto_attendance_result.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/geofence_transition.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/disable_auto_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/enable_auto_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/handle_geofence_transition_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/sync_auto_attendance_zone_use_case.dart';
import 'auto_attendance_test_doubles.dart';

Failure _featureOff() =>
    Failure('off', 403, const {'code': 'ATTENDANCE_FEATURE_REQUIRED'});

void main() {
  late FakeAttendanceRepo repo;
  late FakeStore store;
  late FakeRegistrar registrar;
  late FakePermission permission;

  setUp(() {
    repo = FakeAttendanceRepo();
    store = FakeStore(enabled: false);
    registrar = FakeRegistrar();
    permission = FakePermission();
  });

  EnableAutoAttendanceUseCase enableCase() => EnableAutoAttendanceUseCase(
    GetCurrentAttendanceUseCase(repo),
    permission,
    registrar,
    store,
  );

  group('enable', () {
    test('registers the shop zone and turns the feature on', () async {
      final result = await enableCase()();

      expect(result, EnableAutoAttendanceResult.enabled);
      expect(store.enabled, isTrue);
      expect(registrar.registered.single.radiusMeters, 200);
    });

    test(
      'stops before asking for permission when there is no shop location',
      () async {
        repo.current = const Right(
          CurrentAttendance(shift: null, config: AttendanceConfig.none()),
        );

        expect(await enableCase()(), EnableAutoAttendanceResult.noShopLocation);
        expect(permission.requests, 0);
        expect(store.enabled, isFalse);
      },
    );

    test('accepts a tiny enforced range and registers the minimum ring', () async {
      repo.current = const Right(
        CurrentAttendance(
          shift: null,
          config: AttendanceConfig(
            shopLat: 30,
            shopLng: 31,
            rangeMeters: 5,
            enforced: true,
          ),
        ),
      );

      expect(await enableCase()(), EnableAutoAttendanceResult.enabled);
      expect(registrar.registered.single.radiusMeters, 100);
      expect(registrar.registered.single.trackedRangeMeters, 5);
    });

    test('maps every permission outcome and does not register', () async {
      final cases = {
        BackgroundLocationStatus.whileInUseOnly:
            EnableAutoAttendanceResult.needsAlwaysPermission,
        BackgroundLocationStatus.blocked:
            EnableAutoAttendanceResult.permissionBlocked,
        BackgroundLocationStatus.denied:
            EnableAutoAttendanceResult.permissionDenied,
      };

      for (final entry in cases.entries) {
        permission.afterRequest = entry.key;
        expect(await enableCase()(), entry.value);
      }
      expect(registrar.registered, isEmpty);
      expect(store.enabled, isFalse);
    });

    test(
      'fails when the settings cannot be read or the zone cannot be registered',
      () async {
        repo.current = Left(Failure('x', null, const {}));
        expect(await enableCase()(), EnableAutoAttendanceResult.failed);

        repo.current = const Right(
          CurrentAttendance(shift: null, config: shopConfig),
        );
        registrar.succeeds = false;
        expect(await enableCase()(), EnableAutoAttendanceResult.failed);
        expect(store.enabled, isFalse);
      },
    );
  });

  group('disable', () {
    test('removes the zone and turns the feature off', () async {
      store.enabled = true;

      await DisableAutoAttendanceUseCase(registrar, store)();

      expect(registrar.clears, 1);
      expect(store.enabled, isFalse);
    });
  });

  group('sync', () {
    SyncAutoAttendanceZoneUseCase syncCase() => SyncAutoAttendanceZoneUseCase(
      GetCurrentAttendanceUseCase(repo),
      permission,
      registrar,
      store,
      DisableAutoAttendanceUseCase(registrar, store),
    );

    test('does nothing while the feature is off', () async {
      await syncCase()();

      expect(registrar.registered, isEmpty);
      expect(registrar.clears, 0);
    });

    test('registers the latest zone while on', () async {
      store.enabled = true;

      await syncCase()();

      expect(registrar.registered, hasLength(1));
      expect(store.enabled, isTrue);
    });

    test('turns itself off when location access was taken away', () async {
      store.enabled = true;
      permission.current = BackgroundLocationStatus.whileInUseOnly;

      await syncCase()();

      expect(store.enabled, isFalse);
      expect(registrar.clears, 1);
    });

    test('turns itself off when the owner removed the shop location', () async {
      store.enabled = true;
      repo.current = const Right(
        CurrentAttendance(shift: null, config: AttendanceConfig.none()),
      );

      await syncCase()();

      expect(store.enabled, isFalse);
    });

    test('turns itself off when the subscription stopped', () async {
      store.enabled = true;
      repo.current = Left(_featureOff());

      await syncCase()();

      expect(store.enabled, isFalse);
    });

    test('keeps going when the network is down', () async {
      store.enabled = true;
      repo.current = Left(Failure('offline', null, const {}));

      await syncCase()();

      expect(store.enabled, isTrue);
      expect(registrar.clears, 0);
    });
  });

  group('transition', () {
    HandleGeofenceTransitionUseCase handler() =>
        HandleGeofenceTransitionUseCase(
          GetCurrentAttendanceUseCase(repo),
          CheckInAttendanceUseCase(repo),
          CheckOutAttendanceUseCase(repo),
          store,
          registrar,
        );

    CurrentAttendance onShift() =>
        CurrentAttendance(shift: openShift(), config: shopConfig);

    CurrentAttendance offShift() =>
        const CurrentAttendance(shift: null, config: shopConfig);

    setUp(() => store.enabled = true);

    test(
      'arriving checks in with the automatic method and the location',
      () async {
        final outcome = await handler()(
          GeofenceTransition.entered,
          lat: 30.1,
          lng: 31.2,
        );

        expect(outcome, AutoAttendanceOutcome.checkedIn);
        expect(repo.calls, ['in']);
        expect(repo.lastMethod, AttendanceMethod.auto);
        expect(repo.lastLat, 30.1);
      },
    );

    test('arriving while already on shift does nothing', () async {
      repo.current = Right(onShift());

      final outcome = await handler()(GeofenceTransition.entered);

      expect(outcome, AutoAttendanceOutcome.alreadyOnShift);
      expect(repo.calls, isEmpty);
    });

    test('leaving checks out only when a shift is open', () async {
      expect(
        await handler()(GeofenceTransition.exited),
        AutoAttendanceOutcome.noOpenShift,
      );

      repo.current = Right(onShift());

      expect(
        await handler()(GeofenceTransition.exited),
        AutoAttendanceOutcome.checkedOut,
      );
      expect(repo.calls, ['out']);
      expect(repo.lastMethod, AttendanceMethod.auto);
    });

    test(
      'a repeated event is harmless because the shift state decides',
      () async {
        await handler()(GeofenceTransition.entered);
        repo.current = Right(onShift());

        final second = await handler()(GeofenceTransition.entered);

        expect(second, AutoAttendanceOutcome.alreadyOnShift);
        expect(repo.calls, ['in']);
      },
    );

    test('coming back right after leaving checks in again', () async {
      repo.current = Right(onShift());
      await handler()(GeofenceTransition.exited);

      repo.current = Right(offShift());
      final again = await handler()(GeofenceTransition.entered);

      expect(again, AutoAttendanceOutcome.checkedIn);
      expect(repo.calls, ['out', 'in']);
    });

    test('a failed attempt is reported and can be retried at once', () async {
      repo.checkInResult = Left(Failure('far', 400, const {}));

      expect(
        await handler()(GeofenceTransition.entered),
        AutoAttendanceOutcome.failed,
      );

      repo.checkInResult = null;
      expect(
        await handler()(GeofenceTransition.entered),
        AutoAttendanceOutcome.checkedIn,
      );
    });

    test('a stopped subscription is ignored quietly', () async {
      repo.current = Left(_featureOff());

      expect(
        await handler()(GeofenceTransition.entered),
        AutoAttendanceOutcome.featureInactive,
      );
    });

    test('an unreadable status is a failure', () async {
      repo.current = Left(Failure('offline', null, const {}));

      expect(
        await handler()(GeofenceTransition.entered),
        AutoAttendanceOutcome.failed,
      );
    });

    test('events after the feature was turned off clear the zone', () async {
      store.enabled = false;

      final outcome = await handler()(GeofenceTransition.entered);

      expect(outcome, AutoAttendanceOutcome.disabled);
      expect(registrar.clears, 1);
      expect(repo.calls, isEmpty);
    });
  });
}
