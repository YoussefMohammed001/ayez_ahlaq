import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_history_page.dart';
import '../repos/i_barber_attendance_repo.dart';

class GetAttendanceHistoryUseCase {
  final IBarberAttendanceRepo _repo;

  GetAttendanceHistoryUseCase(this._repo);

  Future<Either<Failure, AttendanceHistoryPage>> call({required int page}) =>
      _repo.getHistory(page: page);
}
