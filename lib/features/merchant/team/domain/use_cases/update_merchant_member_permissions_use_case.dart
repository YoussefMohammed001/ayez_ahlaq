import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../entities/merchant_member_permissions.dart';
import '../repos/i_merchant_team_repo.dart';

class UpdateMerchantMemberPermissionsUseCase {
  final IMerchantTeamRepo _repo;

  UpdateMerchantMemberPermissionsUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call(
    int id,
    MerchantMemberPermissions permissions,
  ) => _repo.updatePermissions(id, permissions);
}
