import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/barber_attendance_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/barber_attendance_state.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/models/attendance_feature_status_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_requests_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/repos/i_attendance_feature_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/get_attendance_feature_status_use_case.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/device_location_result.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/location_availability.dart';
import 'package:ayez_ahlaq/shared/location/domain/repos/i_location_repo.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/get_current_location_use_case.dart';

AttendanceFeatureStatus _status({
  required bool enabled,
  String state = 'NONE',
  bool owner = true,
}) => AttendanceFeatureStatusModel.fromJson({
  'enabled': enabled,
  'state': state,
  'owner': owner,
  'message': 'm',
  'price': 10,
  'canRequest': !enabled,
});

final _featureRequired = Failure(
  'ميزة الحضور والانصراف غير مفعّلة لمحلك',
  403,
  const {'code': 'ATTENDANCE_FEATURE_REQUIRED'},
);

class _FeatureRepo implements IAttendanceFeatureRepo {
  final List<Either<Failure, AttendanceFeatureStatus>> answers;
  int calls = 0;

  _FeatureRepo(this.answers);

  @override
  Future<Either<Failure, AttendanceFeatureStatus>> getStatus() async =>
      answers[calls++ < answers.length ? calls - 1 : answers.length - 1];

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

class _AttendanceRepo implements IBarberAttendanceRepo {
  Either<Failure, CurrentAttendance> currentResult = const Right(
    CurrentAttendance(shift: null, config: AttendanceConfig.none()),
  );
  Either<Failure, CurrentAttendance>? checkInResult;
  int currentCalls = 0;

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() async {
    currentCalls++;
    return currentResult;
  }

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
  }) async => checkInResult ?? currentResult;

  @override
  Future<Either<Failure, Unit>> checkOut({double? lat, double? lng}) async =>
      const Right(unit);

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
  }) => throw UnimplementedError();
}

class _LocationRepo implements ILocationRepo {
  @override
  Future<DeviceLocationResult> currentLocation({
    required bool requestPermission,
  }) async => const DeviceLocationResult(LocationAvailability.unavailable);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late _AttendanceRepo attendance;

  BarberAttendanceCubit build(_FeatureRepo feature) => BarberAttendanceCubit(
    GetCurrentAttendanceUseCase(attendance),
    CheckInAttendanceUseCase(attendance),
    CheckOutAttendanceUseCase(attendance),
    GetCurrentLocationUseCase(_LocationRepo()),
    GetAttendanceFeatureStatusUseCase(feature),
  );

  setUp(() => attendance = _AttendanceRepo());

  test('a locked feature never asks for the attendance data', () async {
    final cubit = build(_FeatureRepo([Right(_status(enabled: false))]));

    await cubit.load();

    expect(attendance.currentCalls, 0);
    expect(cubit.state.isLocked, true);
    expect(cubit.state.hasLoaded, true);
    expect(cubit.state.status, BarberAttendanceStatus.success);
    expect(cubit.state.errorMessage, isNull);
  });

  test('a pending request keeps the feature locked', () async {
    final cubit = build(
      _FeatureRepo([Right(_status(enabled: false, state: 'PENDING'))]),
    );

    await cubit.load();

    expect(cubit.state.isLocked, true);
    expect(cubit.state.feature.isPending, true);
  });

  test('an active feature loads the attendance data', () async {
    final cubit = build(
      _FeatureRepo([Right(_status(enabled: true, state: 'ACTIVE'))]),
    );

    await cubit.load();

    expect(attendance.currentCalls, 1);
    expect(cubit.state.isLocked, false);
    expect(cubit.state.feature.enabled, true);
  });

  test('a failed status call shows the failure and stays unlocked', () async {
    final cubit = build(
      _FeatureRepo([Left(Failure('لا يوجد اتصال', null, const {}))]),
    );

    await cubit.load();

    expect(cubit.state.status, BarberAttendanceStatus.failure);
    expect(cubit.state.errorMessage, 'لا يوجد اتصال');
    expect(cubit.state.isLocked, false);
    expect(attendance.currentCalls, 0);
  });

  test('the feature ending between two calls locks the screen quietly', () async {
    attendance.currentResult = Left(_featureRequired);
    final feature = _FeatureRepo([
      Right(_status(enabled: true, state: 'ACTIVE')),
      Right(_status(enabled: false, state: 'EXPIRED')),
    ]);
    final cubit = build(feature);

    await cubit.load();

    expect(cubit.state.isLocked, true);
    expect(cubit.state.feature.isExpired, true);
    expect(cubit.state.errorMessage, isNull);
    expect(cubit.state.status, BarberAttendanceStatus.success);
  });

  test('a check in refused for the feature turns into the locked view', () async {
    final feature = _FeatureRepo([
      Right(_status(enabled: true, state: 'ACTIVE')),
      Right(_status(enabled: false, state: 'EXPIRED')),
    ]);
    final cubit = build(feature);
    await cubit.load();
    attendance.checkInResult = Left(_featureRequired);

    final done = await cubit.checkIn();

    expect(done, false);
    expect(cubit.state.isLocked, true);
    expect(cubit.state.errorMessage, isNull);
    expect(cubit.state.isSubmitting, false);
  });

  test('another check in failure keeps the message and the screen', () async {
    final cubit = build(
      _FeatureRepo([Right(_status(enabled: true, state: 'ACTIVE'))]),
    );
    await cubit.load();
    attendance.checkInResult = Left(Failure('بعيد عن المحل', 400, const {}));

    final done = await cubit.checkIn();

    expect(done, false);
    expect(cubit.state.isLocked, false);
    expect(cubit.state.errorMessage, 'بعيد عن المحل');
  });
}
