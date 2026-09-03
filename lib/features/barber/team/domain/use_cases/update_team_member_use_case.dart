import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/team_member_detail.dart';
import '../repos/i_barber_team_repo.dart';

class UpdateTeamMemberUseCase {
  final IBarberTeamRepo _repo;

  UpdateTeamMemberUseCase(this._repo);

  Future<Either<Failure, TeamMemberDetail>> call({
    required int id,
    required String name,
    required String tagline,
  }) => _repo.updateMember(id: id, name: name, tagline: tagline);
}
