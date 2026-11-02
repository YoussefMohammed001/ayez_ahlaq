import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_settings.dart';
import '../repos/i_barber_attendance_admin_repo.dart';

class GetAttendanceSettingsUseCase {
  final IBarberAttendanceAdminRepo _repo;

  GetAttendanceSettingsUseCase(this._repo);

  Future<Either<Failure, AttendanceSettings>> call() => _repo.getSettings();
}
