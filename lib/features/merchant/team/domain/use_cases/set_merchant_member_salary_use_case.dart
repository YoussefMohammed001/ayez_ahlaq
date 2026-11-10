import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../repos/i_merchant_team_repo.dart';

class SetMerchantMemberSalaryUseCase {
  final IMerchantTeamRepo _repo;

  SetMerchantMemberSalaryUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call(int id, double salary) =>
      _repo.setSalary(id, salary);
}
