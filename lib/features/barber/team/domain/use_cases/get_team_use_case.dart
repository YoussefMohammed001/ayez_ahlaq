import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/team_member.dart';
import '../repos/i_barber_team_repo.dart';

class GetTeamUseCase {
  final IBarberTeamRepo _repo;

  GetTeamUseCase(this._repo);

  Future<Either<Failure, List<TeamMember>>> call() => _repo.getTeam();
}
