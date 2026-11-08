import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_method.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_shift.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/barber_attendance_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_requests_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/repos/i_attendance_feature_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/get_attendance_feature_status_use_case.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/device_location_result.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/geo_point.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/location_availability.dart';
import 'package:ayez_ahlaq/shared/location/domain/repos/i_location_repo.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/get_current_location_use_case.dart';

final _shift = AttendanceShift(
  id: 1,
  barberId: 10,
  barberName: 'x',
  checkInAt: DateTime(2026, 11, 3, 10),
  checkOutAt: null,
  durationMinutes: 0,
  status: AttendanceStatus.open,
  checkInDistanceMeters: null,
  adjustNote: null,
);

class _FakeRepo implements IBarberAttendanceRepo {
  AttendanceConfig config = const AttendanceConfig.none();
  Either<Failure, CurrentAttendance>? checkInResult;
  int checkInCalls = 0;
  double? lastLat;
  double? lastLng;
  bool checkedOut = false;

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() async =>
      Right(CurrentAttendance(shift: null, config: config));

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    checkInCalls++;
    lastLat = lat;
    lastLng = lng;
    return checkInResult ??
        Right(CurrentAttendance(shift: _shift, config: config));
  }

  @override
  Future<Either<Failure, Unit>> checkOut({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    checkedOut = true;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
    DateTime? from,
  }) => throw UnimplementedError();
}

class _FakeFeatureRepo implements IAttendanceFeatureRepo {
  AttendanceFeatureStatus status = const AttendanceFeatureStatus.ungated();
  int statusCalls = 0;

  @override
  Future<Either<Failure, AttendanceFeatureStatus>> getStatus() async {
    statusCalls++;
    return Right(status);
  }

  @override
  Future<Either<Failure, Unit>> requestFeature() => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> cancelRequest(int id) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, AttendanceFeatureRequestsPage>> getRequests({
    required int page,
  }) => throw UnimplementedError();
}

class _FakeLocationRepo implements ILocationRepo {
  DeviceLocationResult result;

  _FakeLocationRepo(this.result);

  @override
  Future<DeviceLocationResult> currentLocation({
    required bool requestPermission,
  }) async => result;

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late _FakeRepo repo;
  late _FakeFeatureRepo featureRepo;
  late _FakeLocationRepo location;

  BarberAttendanceCubit build() => BarberAttendanceCubit(
    GetCurrentAttendanceUseCase(repo),
    CheckInAttendanceUseCase(repo),
    CheckOutAttendanceUseCase(repo),
    GetCurrentLocationUseCase(location),
    GetAttendanceFeatureStatusUseCase(featureRepo),
  );

  setUp(() {
    featureRepo = _FakeFeatureRepo();
    repo = _FakeRepo();
    location = _FakeLocationRepo(
      const DeviceLocationResult(
        LocationAvailability.available,
        GeoPoint(30.3, 31.7),
      ),
    );
  });

  test('check in sends the device coordinates', () async {
    final cubit = build();
    await cubit.load();

    final done = await cubit.checkIn();

    expect(done, true);
    expect(repo.lastLat, 30.3);
    expect(repo.lastLng, 31.7);
    expect(cubit.state.current.onShift, true);
    expect(cubit.state.isSubmitting, false);
  });

  test('enforced range without a location never calls the server', () async {
    repo.config = const AttendanceConfig(
      shopLat: 30.3,
      shopLng: 31.7,
      rangeMeters: 150,
      enforced: true,
    );
    location = _FakeLocationRepo(
      const DeviceLocationResult(LocationAvailability.serviceDisabled),
    );
    final cubit = build();
    await cubit.load();

    final done = await cubit.checkIn();

    expect(done, false);
    expect(repo.checkInCalls, 0);
    expect(cubit.state.errorMessage, isNotNull);
    expect(cubit.state.current.onShift, false);
  });

  test('range off and no location still checks in without coordinates', () async {
    location = _FakeLocationRepo(
      const DeviceLocationResult(LocationAvailability.permissionDenied),
    );
    final cubit = build();
    await cubit.load();

    final done = await cubit.checkIn();

    expect(done, true);
    expect(repo.checkInCalls, 1);
    expect(repo.lastLat, isNull);
    expect(repo.lastLng, isNull);
  });

  test('a server rejection keeps the message and the old state', () async {
    repo.checkInResult = Left(
      Failure(
        'أنت على بعد 300 متر من المحل — الحد المسموح 150 متر',
        400,
        const {'distanceMeters': 300, 'rangeMeters': 150},
      ),
    );
    final cubit = build();
    await cubit.load();

    final done = await cubit.checkIn();

    expect(done, false);
    expect(cubit.state.errorMessage, contains('300'));
    expect(cubit.state.current.onShift, false);
    expect(cubit.state.isSubmitting, false);
  });

  test('check out clears the shift but keeps the config', () async {
    repo.config = const AttendanceConfig(
      shopLat: 30.3,
      shopLng: 31.7,
      rangeMeters: 150,
      enforced: true,
    );
    final cubit = build();
    await cubit.load();
    await cubit.checkIn();
    expect(cubit.state.current.onShift, true);

    final done = await cubit.checkOut();

    expect(done, true);
    expect(repo.checkedOut, true);
    expect(cubit.state.current.onShift, false);
    expect(cubit.state.current.config.rangeMeters, 150);
  });
}
