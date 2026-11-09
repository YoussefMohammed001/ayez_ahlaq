import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_commission.dart';

abstract class IMemberCommissionRepo {
  Future<Either<Failure, MemberCommission>> get(int memberId);

  Future<Either<Failure, MemberCommission>> set(
    int memberId, {
    required bool enabled,
    double? percent,
  });
}
