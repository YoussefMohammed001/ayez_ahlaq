import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/team_attendance_member.dart';
import '../repos/i_barber_attendance_admin_repo.dart';

class GetTeamAttendanceUseCase {
  final IBarberAttendanceAdminRepo _repo;

  GetTeamAttendanceUseCase(this._repo);

  Future<Either<Failure, List<TeamAttendanceMember>>> call() => _repo.getTeam();
}
