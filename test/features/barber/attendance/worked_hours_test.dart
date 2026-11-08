import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_method.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_shift.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/worked_hours.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_worked_hours_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/worked_hours_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/worked_hours_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

final _now = DateTime(2026, 11, 8, 15);

AttendanceShift _shift(DateTime checkIn, int minutes) => AttendanceShift(
  id: checkIn.millisecondsSinceEpoch,
  barberId: 1,
  barberName: 'x',
  checkInAt: checkIn,
  checkOutAt: null,
  durationMinutes: minutes,
  status: AttendanceStatus.closed,
  checkInDistanceMeters: null,
  adjustNote: null,
);

class _Repo implements IBarberAttendanceRepo {
  final List<List<AttendanceShift>> pages;
  Failure? failure;
  final requestedPages = <int>[];
  DateTime? lastFrom;

  _Repo(this.pages);

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
    DateTime? from,
  }) async {
    requestedPages.add(page);
    lastFrom = from;
    if (failure != null) return Left(failure!);
    return Right(
      AttendanceHistoryPage(
        shifts: pages[page],
        page: page,
        totalPages: pages.length,
      ),
    );
  }

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> checkOut({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) => throw UnimplementedError();
}

void main() {
  group('WorkedHours.from', () {
    test('splits today from the rest of the month', () {
      final hours = WorkedHours.from([
        _shift(DateTime(2026, 11, 8, 9), 120),
        _shift(DateTime(2026, 11, 8, 13), 30),
        _shift(DateTime(2026, 11, 3, 10), 480),
      ], _now);

      expect(hours.todayMinutes, 150);
      expect(hours.monthMinutes, 630);
    });

    test('ignores shifts of another month', () {
      final hours = WorkedHours.from([
        _shift(DateTime(2026, 10, 8, 9), 600),
        _shift(DateTime(2025, 11, 8, 9), 600),
      ], _now);

      expect(hours, const WorkedHours.none());
    });

    test('the same day of another month is not today', () {
      final hours = WorkedHours.from([
        _shift(DateTime(2026, 10, 8, 9), 60),
      ], _now);

      expect(hours.todayMinutes, 0);
    });

    test('nothing worked gives zeros', () {
      expect(WorkedHours.from(const [], _now), const WorkedHours.none());
    });
  });

  group('GetWorkedHoursUseCase', () {
    test('asks only for the current month', () async {
      final repo = _Repo([[]]);

      await GetWorkedHoursUseCase(repo)(now: _now);

      expect(repo.lastFrom, DateTime(2026, 11));
    });

    test('adds up every page', () async {
      final repo = _Repo([
        [_shift(DateTime(2026, 11, 8, 9), 60)],
        [_shift(DateTime(2026, 11, 2, 9), 90)],
      ]);

      final result = await GetWorkedHoursUseCase(repo)(now: _now);

      expect(repo.requestedPages, [0, 1]);
      expect(
        result.getOrElse(() => const WorkedHours.none()),
        const WorkedHours(todayMinutes: 60, monthMinutes: 150),
      );
    });

    test('stops at the last page', () async {
      final repo = _Repo([[]]);

      await GetWorkedHoursUseCase(repo)(now: _now);

      expect(repo.requestedPages, [0]);
    });

    test('a failed page fails the whole answer', () async {
      final repo = _Repo([[]])..failure = Failure('no', 400, const {});

      final result = await GetWorkedHoursUseCase(repo)(now: _now);

      expect(result.isLeft(), isTrue);
    });
  });

  group('WorkedHoursCubit', () {
    test('shows the hours once loaded', () async {
      final cubit = WorkedHoursCubit(
        GetWorkedHoursUseCase(
          _Repo([
            [_shift(DateTime.now(), 45)],
          ]),
        ),
      );

      expect(cubit.state.isVisible, isFalse);
      await cubit.load();

      expect(cubit.state.status, WorkedHoursStatus.success);
      expect(cubit.state.hours.monthMinutes, 45);
      await cubit.close();
    });

    test('stays hidden when loading fails', () async {
      final repo = _Repo([[]])..failure = Failure('no', 400, const {});
      final cubit = WorkedHoursCubit(GetWorkedHoursUseCase(repo));

      await cubit.load();

      expect(cubit.state.isVisible, isFalse);
      await cubit.close();
    });
  });
}
