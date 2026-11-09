import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_commission.dart';
import '../repos/i_member_commission_repo.dart';

class GetMemberCommissionUseCase {
  final IMemberCommissionRepo _repo;

  GetMemberCommissionUseCase(this._repo);

  Future<Either<Failure, MemberCommission>> call(int memberId) =>
      _repo.get(memberId);
}
