import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../repos/i_merchant_team_repo.dart';

class ActivateMerchantMemberUseCase {
  final IMerchantTeamRepo _repo;

  ActivateMerchantMemberUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call(int id) =>
      _repo.activateMember(id);
}
