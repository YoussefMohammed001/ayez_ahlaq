import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_setting_log_page.dart';
import '../repos/i_barber_attendance_admin_repo.dart';

class GetAttendanceSettingLogUseCase {
  final IBarberAttendanceAdminRepo _repo;

  GetAttendanceSettingLogUseCase(this._repo);

  Future<Either<Failure, AttendanceSettingLogPage>> call({required int page}) =>
      _repo.getSettingLog(page: page);
}
