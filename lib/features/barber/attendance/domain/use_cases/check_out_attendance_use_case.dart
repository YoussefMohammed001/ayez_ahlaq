import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_attendance_repo.dart';

class CheckOutAttendanceUseCase {
  final IBarberAttendanceRepo _repo;

  CheckOutAttendanceUseCase(this._repo);

  Future<Either<Failure, Unit>> call({double? lat, double? lng}) =>
      _repo.checkOut(lat: lat, lng: lng);
}
