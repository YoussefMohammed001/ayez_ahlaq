import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_attendance_history_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepo extends Fake implements IBarberAttendanceRepo {
  final pages = <int>[];

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
    DateTime? from,
  }) async {
    pages.add(page);
    return Right(
      AttendanceHistoryPage(shifts: const [], page: page, totalPages: 2),
    );
  }
}

void main() {
  test(
    'a member history cubit loads pages and cannot correct a shift',
    () async {
      final repo = _FakeRepo();
      final cubit = AttendanceHistoryCubit(
        GetAttendanceHistoryUseCase(repo),
        null,
      );

      await cubit.load();
      await cubit.loadMore();
      final corrected = await cubit.correct(
        id: 1,
        checkInAt: DateTime(2026, 11, 11, 9),
        checkOutAt: DateTime(2026, 11, 11, 17),
        note: 'x',
      );

      expect(repo.pages, [0, 1]);
      expect(corrected, isFalse);
      expect(cubit.state.isSubmitting, isFalse);
    },
  );
}
