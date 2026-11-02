import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/current_attendance.dart';
import '../repos/i_barber_attendance_repo.dart';

class GetCurrentAttendanceUseCase {
  final IBarberAttendanceRepo _repo;

  GetCurrentAttendanceUseCase(this._repo);

  Future<Either<Failure, CurrentAttendance>> call() => _repo.getCurrent();
}
