import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/current_attendance.dart';
import '../repos/i_barber_attendance_repo.dart';

class CheckInAttendanceUseCase {
  final IBarberAttendanceRepo _repo;

  CheckInAttendanceUseCase(this._repo);

  Future<Either<Failure, CurrentAttendance>> call({double? lat, double? lng}) =>
      _repo.checkIn(lat: lat, lng: lng);
}
