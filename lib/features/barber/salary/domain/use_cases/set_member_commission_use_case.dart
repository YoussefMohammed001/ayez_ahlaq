import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_commission.dart';
import '../repos/i_member_commission_repo.dart';

class SetMemberCommissionUseCase {
  final IMemberCommissionRepo _repo;

  SetMemberCommissionUseCase(this._repo);

  Future<Either<Failure, MemberCommission>> call(
    int memberId, {
    required bool enabled,
    double? percent,
  }) => _repo.set(memberId, enabled: enabled, percent: percent);
}
