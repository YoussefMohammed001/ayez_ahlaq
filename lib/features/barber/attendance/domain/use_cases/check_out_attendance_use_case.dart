import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_method.dart';
import '../repos/i_barber_attendance_repo.dart';

class CheckOutAttendanceUseCase {
  final IBarberAttendanceRepo _repo;

  CheckOutAttendanceUseCase(this._repo);

  Future<Either<Failure, Unit>> call({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) => _repo.checkOut(lat: lat, lng: lng, method: method);
}
