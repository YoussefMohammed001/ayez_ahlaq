import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_settings.dart';
import '../repos/i_barber_attendance_admin_repo.dart';

class UpdateAttendanceSettingsUseCase {
  final IBarberAttendanceAdminRepo _repo;

  UpdateAttendanceSettingsUseCase(this._repo);

  Future<Either<Failure, AttendanceSettings>> call({
    required bool enforced,
    int? rangeMeters,
  }) => _repo.updateSettings(enforced: enforced, rangeMeters: rangeMeters);
}
