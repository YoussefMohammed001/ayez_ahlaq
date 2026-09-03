import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/team_member_detail.dart';
import '../repos/i_barber_team_repo.dart';

class AddTeamMemberUseCase {
  final IBarberTeamRepo _repo;

  AddTeamMemberUseCase(this._repo);

  Future<Either<Failure, TeamMemberDetail>> call({
    required String name,
    required String phoneNumber,
    String? tagline,
  }) => _repo.addMember(name: name, phoneNumber: phoneNumber, tagline: tagline);
}
