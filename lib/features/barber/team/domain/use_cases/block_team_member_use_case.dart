import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/team_member_detail.dart';
import '../repos/i_barber_team_repo.dart';

class BlockTeamMemberUseCase {
  final IBarberTeamRepo _repo;

  BlockTeamMemberUseCase(this._repo);

  Future<Either<Failure, TeamMemberDetail>> call(int id) =>
      _repo.blockMember(id);
}
