import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../repos/i_merchant_team_repo.dart';

class UpdateMerchantMemberUseCase {
  final IMerchantTeamRepo _repo;

  UpdateMerchantMemberUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call({
    required int id,
    String? name,
    String? phoneNumber,
    double? salary,
  }) => _repo.updateMember(
    id: id,
    name: name,
    phoneNumber: phoneNumber,
    salary: salary,
  );
}
