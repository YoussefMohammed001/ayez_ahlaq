import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_shift.dart';
import '../entities/worked_hours.dart';
import '../repos/i_barber_attendance_repo.dart';

class GetWorkedHoursUseCase {
  static const int _pageSize = 100;
  static const int _maxPages = 10;

  final IBarberAttendanceRepo _repo;

  GetWorkedHoursUseCase(this._repo);

  Future<Either<Failure, WorkedHours>> call({DateTime? now}) async {
    final current = now ?? DateTime.now();
    final monthStart = DateTime(current.year, current.month);
    final shifts = <AttendanceShift>[];

    for (var page = 0; page < _maxPages; page++) {
      final result = await _repo.getHistory(
        page: page,
        size: _pageSize,
        from: monthStart,
      );

      final failure = result.fold<Failure?>((f) => f, (_) => null);
      if (failure != null) return Left(failure);

      final loaded = result.getOrElse(() => throw StateError('unreachable'));
      shifts.addAll(loaded.shifts);
      if (!loaded.hasMore) break;
    }

    return Right(WorkedHours.from(shifts, current));
  }
}
