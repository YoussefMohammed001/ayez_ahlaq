import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_team_repo.dart';

class DeleteTeamMemberPermanentlyUseCase {
  final IBarberTeamRepo _repo;

  DeleteTeamMemberPermanentlyUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) =>
      _repo.deleteMemberPermanently(id);
}
