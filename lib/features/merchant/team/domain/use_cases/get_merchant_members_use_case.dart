import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_members_page.dart';
import '../repos/i_merchant_team_repo.dart';

class GetMerchantMembersUseCase {
  final IMerchantTeamRepo _repo;

  GetMerchantMembersUseCase(this._repo);

  Future<Either<Failure, MerchantMembersPage>> call({
    required int page,
    required int size,
  }) => _repo.getMembers(page: page, size: size);
}
