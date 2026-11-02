import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_setting_log_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_settings.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_shift.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/team_attendance_member.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_admin_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/correct_attendance_record_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_attendance_history_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_attendance_settings_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/update_attendance_settings_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_settings_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_settings_state.dart';

AttendanceShift _shift(int id, {String? note}) => AttendanceShift(
  id: id,
  barberId: 10,
  barberName: 'x',
  checkInAt: DateTime(2026, 11, 2, 9),
  checkOutAt: DateTime(2026, 11, 2, 10),
  durationMinutes: 60,
  status: note == null ? AttendanceStatus.closed : AttendanceStatus.adjusted,
  checkInDistanceMeters: null,
  adjustNote: note,
);

class _FakeAdminRepo implements IBarberAttendanceAdminRepo {
  AttendanceSettings settings = const AttendanceSettings(
    config: AttendanceConfig.none(),
    updatedByName: null,
    updatedAt: null,
  );
  Either<Failure, AttendanceSettings>? updateResult;
  bool? lastEnforced;
  int? lastRange;
  Either<Failure, AttendanceShift>? correctResult;

  @override
  Future<Either<Failure, AttendanceSettings>> getSettings() async =>
      Right(settings);

  @override
  Future<Either<Failure, AttendanceSettings>> updateSettings({
    required bool enforced,
    int? rangeMeters,
  }) async {
    lastEnforced = enforced;
    lastRange = rangeMeters;
    return updateResult ??
        Right(
          AttendanceSettings(
            config: AttendanceConfig(
              shopLat: 1,
              shopLng: 1,
              rangeMeters: rangeMeters,
              enforced: enforced,
            ),
            updatedByName: 'owner',
            updatedAt: DateTime(2026, 11, 3),
          ),
        );
  }

  @override
  Future<Either<Failure, AttendanceShift>> correctRecord({
    required int id,
    required DateTime checkInAt,
    required DateTime checkOutAt,
    required String note,
  }) async => correctResult ?? Right(_shift(id, note: note));

  @override
  Future<Either<Failure, List<TeamAttendanceMember>>> getTeam() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, AttendanceSettingLogPage>> getSettingLog({
    required int page,
  }) => throw UnimplementedError();
}

class _FakeHistoryRepo implements IBarberAttendanceRepo {
  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
  }) async => Right(
    AttendanceHistoryPage(shifts: [_shift(1), _shift(2)], page: 0, totalPages: 1),
  );

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> checkOut({double? lat, double? lng}) =>
      throw UnimplementedError();
}

void main() {
  late _FakeAdminRepo admin;

  setUp(() => admin = _FakeAdminRepo());

  AttendanceSettingsCubit settingsCubit() => AttendanceSettingsCubit(
    GetAttendanceSettingsUseCase(admin),
    UpdateAttendanceSettingsUseCase(admin),
  );

  test('settings load and save update the state', () async {
    final cubit = settingsCubit();
    await cubit.load();

    expect(cubit.state.status, AttendanceSettingsStatus.success);
    expect(cubit.state.settings!.config.enforced, false);

    final saved = await cubit.save(enforced: true, rangeMeters: 150);

    expect(saved, true);
    expect(admin.lastEnforced, true);
    expect(admin.lastRange, 150);
    expect(cubit.state.settings!.config.rangeMeters, 150);
    expect(cubit.state.settings!.updatedByName, 'owner');
    expect(cubit.state.isSubmitting, false);
  });

  test('a rejected save keeps the old settings and the message', () async {
    admin.updateResult = Left(
      Failure('حدد المسافة المسموحة أولاً', 400, const {}),
    );
    final cubit = settingsCubit();
    await cubit.load();

    final saved = await cubit.save(enforced: true);

    expect(saved, false);
    expect(cubit.state.errorMessage, 'حدد المسافة المسموحة أولاً');
    expect(cubit.state.settings!.config.enforced, false);
    expect(cubit.state.isSubmitting, false);
  });

  AttendanceHistoryCubit historyCubit() => AttendanceHistoryCubit(
    GetAttendanceHistoryUseCase(_FakeHistoryRepo()),
    CorrectAttendanceRecordUseCase(admin),
  );

  test('a correction replaces only that row', () async {
    final cubit = historyCubit();
    await cubit.load();

    final done = await cubit.correct(
      id: 2,
      checkInAt: DateTime(2026, 11, 2, 9),
      checkOutAt: DateTime(2026, 11, 2, 17),
      note: 'forgot to check out',
    );

    expect(done, true);
    expect(cubit.state.shifts.first.status, AttendanceStatus.closed);
    expect(cubit.state.shifts.last.status, AttendanceStatus.adjusted);
    expect(cubit.state.shifts.last.adjustNote, 'forgot to check out');
    expect(cubit.state.isSubmitting, false);
  });

  test('a rejected correction keeps the rows and shows the message', () async {
    admin.correctResult = Left(
      Failure('لا يمكن تسجيل وقت في المستقبل', 400, const {}),
    );
    final cubit = historyCubit();
    await cubit.load();

    final done = await cubit.correct(
      id: 1,
      checkInAt: DateTime(2027),
      checkOutAt: DateTime(2027, 1, 2),
      note: 'x',
    );

    expect(done, false);
    expect(cubit.state.errorMessage, 'لا يمكن تسجيل وقت في المستقبل');
    expect(cubit.state.shifts.every((s) => s.adjustNote == null), true);
  });
}
