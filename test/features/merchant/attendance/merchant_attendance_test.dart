import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/models/current_attendance_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_method.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_shift.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/data/apis/merchant_attendance_api.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/data/repos/merchant_attendance_repo.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/presentation/manager/member_attendance_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/presentation/manager/member_attendance_state.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/device_location_result.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/geo_point.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/location_availability.dart';
import 'package:ayez_ahlaq/shared/location/domain/repos/i_location_repo.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/get_current_location_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

const _devConfig = {
  'merchantLat': 37.4219983,
  'merchantLng': -122.084,
  'rangeMeters': null,
  'enforced': false,
};

const _disabledCurrent = {
  'enabled': false,
  'checkedIn': false,
  'shift': null,
  'attendanceConfig': _devConfig,
};

const _openShift = {
  'id': 12,
  'memberId': 4000014,
  'memberName': 'Sub Test',
  'checkInAt': '2026-11-11T09:00:00',
  'checkOutAt': null,
  'durationMinutes': 0,
  'status': 'OPEN',
  'checkInDistanceMeters': 20,
};

class _FakeApi implements MerchantAttendanceApi {
  Map<String, dynamic>? checkInBody;
  AttendanceMethod? method;
  int? requestedPage;

  @override
  Future<Either<Failure, dynamic>> getCurrent() async =>
      const Right({'data': _disabledCurrent});

  @override
  Future<Either<Failure, dynamic>> checkIn({
    double? lat,
    double? lng,
    required AttendanceMethod method,
  }) async {
    this.method = method;
    checkInBody = {'lat': lat, 'lng': lng};
    return const Right({
      'data': {
        'enabled': true,
        'checkedIn': true,
        'shift': _openShift,
        'attendanceConfig': _devConfig,
      },
    });
  }

  @override
  Future<Either<Failure, dynamic>> getHistory({
    required int page,
    required int size,
  }) async {
    requestedPage = page;
    return const Right({
      'data': {
        'content': [_openShift],
        'page': 0,
        'size': 20,
        'totalElements': 1,
        'totalPages': 1,
      },
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _FakeAttendanceRepo extends Fake implements IBarberAttendanceRepo {
  CurrentAttendance current = const CurrentAttendance.none();
  Failure? checkInFailure;
  int checkInCalls = 0;
  int checkOutCalls = 0;
  double? sentLat;

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() async =>
      Right(current);

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    checkInCalls++;
    sentLat = lat;
    final failure = checkInFailure;
    if (failure != null) return Left(failure);
    return Right(
      CurrentAttendance(
        shift: AttendanceShift(
          id: 1,
          barberId: 1,
          barberName: 'x',
          checkInAt: DateTime(2026, 11, 11, 9),
          checkOutAt: null,
          durationMinutes: 0,
          status: AttendanceStatus.open,
          checkInDistanceMeters: null,
          adjustNote: null,
        ),
        config: current.config,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> checkOut({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    checkOutCalls++;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
    DateTime? from,
  }) => throw UnimplementedError();
}

class _FakeLocationRepo extends Fake implements ILocationRepo {
  DeviceLocationResult result = const DeviceLocationResult(
    LocationAvailability.permissionDenied,
  );

  @override
  Future<DeviceLocationResult> currentLocation({
    required bool requestPermission,
  }) async => result;
}

MemberAttendanceCubit _buildCubit(
  _FakeAttendanceRepo repo,
  _FakeLocationRepo location,
) => MemberAttendanceCubit(
  GetCurrentAttendanceUseCase(repo),
  CheckInAttendanceUseCase(repo),
  CheckOutAttendanceUseCase(repo),
  GetCurrentLocationUseCase(location),
);

void main() {
  group('merchant attendance responses', () {
    test('a disabled plan response keeps the merchant coordinates', () {
      final current = CurrentAttendanceModel.fromJson(_disabledCurrent);

      expect(current.enabled, isFalse);
      expect(current.onShift, isFalse);
      expect(current.config.shopLat, 37.4219983);
      expect(current.config.shopLng, -122.084);
      expect(current.config.rangeMeters, isNull);
      expect(current.config.enforced, isFalse);
    });

    test('the barber response without the flag still counts as enabled', () {
      final current = CurrentAttendanceModel.fromJson({
        'shift': null,
        'attendanceConfig': {'shopLat': 1.0, 'shopLng': 2.0, 'enforced': true},
      });

      expect(current.enabled, isTrue);
      expect(current.config.shopLat, 1.0);
      expect(current.config.enforced, isTrue);
    });

    test('a shift reads memberId and memberName', () async {
      final repo = MerchantAttendanceRepo(_FakeApi());

      final current = (await repo.checkIn(
        lat: 30.0,
        lng: 31.0,
      )).getOrElse(() => throw StateError('failed'));

      expect(current.onShift, isTrue);
      expect(current.shift?.barberId, 4000014);
      expect(current.shift?.barberName, 'Sub Test');
      expect(current.shift?.checkInDistanceMeters, 20);
    });

    test('check in sends the manual method and the position', () async {
      final api = _FakeApi();

      await MerchantAttendanceRepo(api).checkIn(lat: 30.1, lng: 31.2);

      expect(api.method, AttendanceMethod.manual);
      expect(api.checkInBody, {'lat': 30.1, 'lng': 31.2});
    });

    test('history maps the page of shifts', () async {
      final api = _FakeApi();

      final page = (await MerchantAttendanceRepo(
        api,
      ).getHistory(page: 0)).getOrElse(() => throw StateError('failed'));

      expect(api.requestedPage, 0);
      expect(page.shifts.single.id, 12);
      expect(page.hasMore, isFalse);
    });
  });

  group('MemberAttendanceCubit', () {
    late _FakeAttendanceRepo repo;
    late _FakeLocationRepo location;

    setUp(() {
      repo = _FakeAttendanceRepo();
      location = _FakeLocationRepo();
    });

    test('load marks a disabled plan as disabled', () async {
      repo.current = CurrentAttendanceModel.fromJson(_disabledCurrent);
      final cubit = _buildCubit(repo, location);

      await cubit.load();

      expect(cubit.state.status, MemberAttendanceStatus.success);
      expect(cubit.state.isDisabled, isTrue);
    });

    test('an enabled plan is not disabled', () async {
      final cubit = _buildCubit(repo, location);

      await cubit.load();

      expect(cubit.state.isDisabled, isFalse);
    });

    test('check in without a position is allowed when not enforced', () async {
      final cubit = _buildCubit(repo, location);
      await cubit.load();

      final done = await cubit.checkIn();

      expect(done, isTrue);
      expect(repo.checkInCalls, 1);
      expect(repo.sentLat, isNull);
      expect(cubit.state.current.onShift, isTrue);
    });

    test('check in without a position is refused when enforced', () async {
      repo.current = CurrentAttendanceModel.fromJson({
        'enabled': true,
        'shift': null,
        'attendanceConfig': {
          'merchantLat': 1.0,
          'merchantLng': 2.0,
          'rangeMeters': 200,
          'enforced': true,
        },
      });
      final cubit = _buildCubit(repo, location);
      await cubit.load();

      final done = await cubit.checkIn();

      expect(done, isFalse);
      expect(repo.checkInCalls, 0);
      expect(cubit.state.errorMessage, isNotNull);
      expect(cubit.state.isSubmitting, isFalse);
    });

    test('check in sends the device position when there is one', () async {
      location.result = const DeviceLocationResult(
        LocationAvailability.available,
        GeoPoint(30.0445, 31.2358),
      );
      final cubit = _buildCubit(repo, location);
      await cubit.load();

      await cubit.checkIn();

      expect(repo.sentLat, 30.0445);
    });

    test('a server refusal keeps the message and stays off shift', () async {
      repo.checkInFailure = Failure('خارج النطاق', 400, const {});
      location.result = const DeviceLocationResult(
        LocationAvailability.available,
        GeoPoint(30.1, 31.2),
      );
      final cubit = _buildCubit(repo, location);
      await cubit.load();

      final done = await cubit.checkIn();

      expect(done, isFalse);
      expect(cubit.state.errorMessage, 'خارج النطاق');
      expect(cubit.state.current.onShift, isFalse);
    });

    test('check out closes the shift and keeps the range config', () async {
      final cubit = _buildCubit(repo, location);
      await cubit.load();
      await cubit.checkIn();

      final done = await cubit.checkOut();

      expect(done, isTrue);
      expect(repo.checkOutCalls, 1);
      expect(cubit.state.current.onShift, isFalse);
    });
  });
}
