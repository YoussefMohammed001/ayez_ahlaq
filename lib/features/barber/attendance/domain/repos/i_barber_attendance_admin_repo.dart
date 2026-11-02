import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_setting_log_page.dart';
import '../entities/attendance_settings.dart';
import '../entities/attendance_shift.dart';
import '../entities/team_attendance_member.dart';

abstract class IBarberAttendanceAdminRepo {
  Future<Either<Failure, AttendanceSettings>> getSettings();

  Future<Either<Failure, AttendanceSettings>> updateSettings({
    required bool enforced,
    int? rangeMeters,
  });

  Future<Either<Failure, List<TeamAttendanceMember>>> getTeam();

  Future<Either<Failure, AttendanceSettingLogPage>> getSettingLog({
    required int page,
  });

  Future<Either<Failure, AttendanceShift>> correctRecord({
    required int id,
    required DateTime checkInAt,
    required DateTime checkOutAt,
    required String note,
  });
}
