import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_method.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_shift.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_zone.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/background_location_status.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/geofence_transition.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/repos/i_auto_attendance_store.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/repos/i_background_location_permission.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/repos/i_geofence_registrar.dart';

const shopConfig = AttendanceConfig(
  shopLat: 30.05,
  shopLng: 31.23,
  rangeMeters: 200,
  enforced: false,
);

AttendanceShift openShift() => AttendanceShift(
  id: 1,
  barberId: 1,
  barberName: 'كريم',
  checkInAt: DateTime(2026, 11, 5, 9),
  checkOutAt: null,
  durationMinutes: 0,
  status: AttendanceStatus.open,
  checkInDistanceMeters: null,
  adjustNote: null,
);

class FakeAttendanceRepo extends Fake implements IBarberAttendanceRepo {
  Either<Failure, CurrentAttendance> current = const Right(
    CurrentAttendance(shift: null, config: shopConfig),
  );
  Either<Failure, CurrentAttendance>? checkInResult;
  Either<Failure, Unit> checkOutResult = const Right(unit);
  final calls = <String>[];
  AttendanceMethod? lastMethod;
  double? lastLat;

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() async => current;

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    calls.add('in');
    lastMethod = method;
    lastLat = lat;
    return checkInResult ??
        Right(CurrentAttendance(shift: openShift(), config: shopConfig));
  }

  @override
  Future<Either<Failure, Unit>> checkOut({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    calls.add('out');
    lastMethod = method;
    return checkOutResult;
  }

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
  }) => throw UnimplementedError();
}

class FakeStore implements IAutoAttendanceStore {
  bool enabled;
  final events = <GeofenceTransition, DateTime>{};

  FakeStore({this.enabled = true});

  @override
  bool get isEnabled => enabled;

  @override
  Future<void> setEnabled(bool value) async => enabled = value;

  @override
  DateTime? lastEventAt(GeofenceTransition transition) => events[transition];

  @override
  Future<void> saveLastEvent(
    GeofenceTransition transition,
    DateTime at,
  ) async => events[transition] = at;
}

class FakeRegistrar implements IGeofenceRegistrar {
  final registered = <AutoAttendanceZone>[];
  int clears = 0;
  bool succeeds = true;

  @override
  Future<bool> register(AutoAttendanceZone zone) async {
    if (succeeds) registered.add(zone);
    return succeeds;
  }

  @override
  Future<void> clear() async => clears++;
}

class FakePermission implements IBackgroundLocationPermission {
  BackgroundLocationStatus current = BackgroundLocationStatus.granted;
  BackgroundLocationStatus afterRequest = BackgroundLocationStatus.granted;
  int requests = 0;
  int settingsOpened = 0;

  @override
  Future<BackgroundLocationStatus> status() async => current;

  @override
  Future<BackgroundLocationStatus> request() async {
    requests++;
    current = afterRequest;
    return afterRequest;
  }

  @override
  Future<void> openSettings() async => settingsOpened++;
}
