import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/barber_attendance_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/widgets/attendance_home_card.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/models/attendance_feature_status_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_requests_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/repos/i_attendance_feature_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/get_attendance_feature_status_use_case.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/device_location_result.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/location_availability.dart';
import 'package:ayez_ahlaq/shared/location/domain/repos/i_location_repo.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/get_current_location_use_case.dart';

class _FeatureRepo implements IAttendanceFeatureRepo {
  Either<Failure, AttendanceFeatureStatus> answer;

  _FeatureRepo(this.answer);

  @override
  Future<Either<Failure, AttendanceFeatureStatus>> getStatus() async => answer;

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
  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() async => const Right(
    CurrentAttendance(shift: null, config: AttendanceConfig.none()),
  );

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> checkOut({double? lat, double? lng}) =>
      throw UnimplementedError();

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

AttendanceFeatureStatus _status(String state, {bool enabled = false}) =>
    AttendanceFeatureStatusModel.fromJson({
      'enabled': enabled,
      'state': state,
      'owner': false,
      'message': 'تواصل مع صاحب المحل',
    });

BarberAttendanceCubit _cubit(_FeatureRepo feature) => BarberAttendanceCubit(
  GetCurrentAttendanceUseCase(_AttendanceRepo()),
  CheckInAttendanceUseCase(_AttendanceRepo()),
  CheckOutAttendanceUseCase(_AttendanceRepo()),
  GetCurrentLocationUseCase(_LocationRepo()),
  GetAttendanceFeatureStatusUseCase(feature),
);

Widget _host(BarberAttendanceCubit cubit) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, __) => MaterialApp(
    theme: lightTheme,
    home: Scaffold(
      body: BlocProvider.value(
        value: cubit,
        child: const Column(children: [AttendanceHomeCard(), Text('after')]),
      ),
    ),
  ),
);

void main() {
  testWidgets('nothing shows before the status is known', (tester) async {
    final cubit = _cubit(_FeatureRepo(Right(_status('ACTIVE', enabled: true))));

    await tester.pumpWidget(_host(cubit));

    expect(find.text(S().attendanceTitle), findsNothing);
    expect(find.text('after'), findsOneWidget);
  });

  testWidgets('the member sees the card once the owner has subscribed', (
    tester,
  ) async {
    final cubit = _cubit(_FeatureRepo(Right(_status('ACTIVE', enabled: true))));
    await tester.pumpWidget(_host(cubit));

    await cubit.load();
    await tester.pump();

    expect(find.text(S().attendanceTitle), findsOneWidget);
    expect(find.text(S().attendanceOffShift), findsOneWidget);
    expect(find.byIcon(Icons.fingerprint_rounded), findsOneWidget);
  });

  for (final state in ['NONE', 'PENDING', 'EXPIRED', 'SUSPENDED', 'SOMETHING_NEW']) {
    testWidgets('the member sees nothing while the feature is "$state"', (
      tester,
    ) async {
      final cubit = _cubit(_FeatureRepo(Right(_status(state))));
      await tester.pumpWidget(_host(cubit));

      await cubit.load();
      await tester.pump();

      expect(find.text(S().attendanceTitle), findsNothing);
      expect(find.byIcon(Icons.lock_outline_rounded), findsNothing);
      expect(find.text('تواصل مع صاحب المحل'), findsNothing);
    });
  }

  testWidgets('the card appears after the owner subscribes and the home refreshes', (
    tester,
  ) async {
    final repo = _FeatureRepo(Right(_status('PENDING')));
    final cubit = _cubit(repo);
    await tester.pumpWidget(_host(cubit));
    await cubit.load();
    await tester.pump();
    expect(find.text(S().attendanceTitle), findsNothing);

    repo.answer = Right(_status('ACTIVE', enabled: true));
    await cubit.load();
    await tester.pump();

    expect(find.text(S().attendanceTitle), findsOneWidget);
  });

  testWidgets('a failed status call hides the card instead of showing an error', (
    tester,
  ) async {
    final cubit = _cubit(_FeatureRepo(Left(Failure('لا يوجد اتصال', null, const {}))));
    await tester.pumpWidget(_host(cubit));

    await cubit.load();
    await tester.pump();

    expect(find.text(S().attendanceTitle), findsNothing);
  });
}
