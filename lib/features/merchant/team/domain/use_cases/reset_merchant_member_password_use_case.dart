import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_team_repo.dart';

class ResetMerchantMemberPasswordUseCase {
  final IMerchantTeamRepo _repo;

  ResetMerchantMemberPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.resetPassword(id);
}
