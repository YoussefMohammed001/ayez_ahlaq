import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_team_repo.dart';

class DeleteMerchantMemberUseCase {
  final IMerchantTeamRepo _repo;

  DeleteMerchantMemberUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteMember(id);
}
