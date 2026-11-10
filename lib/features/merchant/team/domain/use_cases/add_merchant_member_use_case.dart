import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../entities/merchant_member_permissions.dart';
import '../repos/i_merchant_team_repo.dart';

class AddMerchantMemberUseCase {
  final IMerchantTeamRepo _repo;

  AddMerchantMemberUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call({
    required String name,
    required String phoneNumber,
    String? password,
    double? salary,
    MerchantMemberPermissions permissions = const MerchantMemberPermissions(),
  }) => _repo.addMember(
    name: name,
    phoneNumber: phoneNumber,
    password: password,
    salary: salary,
    permissions: permissions,
  );
}
