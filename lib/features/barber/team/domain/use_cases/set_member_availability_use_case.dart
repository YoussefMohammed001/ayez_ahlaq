import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/team_member_detail.dart';
import '../repos/i_barber_team_repo.dart';

class SetMemberAvailabilityUseCase {
  final IBarberTeamRepo _repo;

  SetMemberAvailabilityUseCase(this._repo);

  Future<Either<Failure, TeamMemberDetail>> call(int id, bool available) =>
      _repo.setAvailability(id, available);
}
