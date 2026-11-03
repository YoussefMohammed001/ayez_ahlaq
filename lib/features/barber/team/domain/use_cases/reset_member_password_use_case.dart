import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_team_repo.dart';

class ResetMemberPasswordUseCase {
  final IBarberTeamRepo _repo;

  ResetMemberPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id, String tempPassword) =>
      _repo.resetPassword(id, tempPassword);
}
