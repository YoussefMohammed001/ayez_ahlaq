import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../repos/i_merchant_team_repo.dart';

class BlockMerchantMemberUseCase {
  final IMerchantTeamRepo _repo;

  BlockMerchantMemberUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call(int id) => _repo.blockMember(id);
}
