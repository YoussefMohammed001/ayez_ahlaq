import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../repos/i_merchant_team_repo.dart';

class GetMerchantMemberUseCase {
  final IMerchantTeamRepo _repo;

  GetMerchantMemberUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call(int id) => _repo.getMember(id);
}
