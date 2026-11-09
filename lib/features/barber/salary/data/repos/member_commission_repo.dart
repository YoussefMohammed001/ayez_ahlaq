import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/member_commission.dart';
import '../../domain/repos/i_member_commission_repo.dart';
import '../apis/member_commission_api.dart';
import '../models/member_commission_model.dart';

class MemberCommissionRepo implements IMemberCommissionRepo {
  final MemberCommissionApi _api;

  MemberCommissionRepo(this._api);

  @override
  Future<Either<Failure, MemberCommission>> get(int memberId) async {
    final result = await _api.get(memberId);
    return result.flatMap(_commissionFrom);
  }

  @override
  Future<Either<Failure, MemberCommission>> set(
    int memberId, {
    required bool enabled,
    double? percent,
  }) async {
    final result = await _api.set(memberId, enabled: enabled, percent: percent);
    return result.flatMap(_commissionFrom);
  }

  Either<Failure, MemberCommission> _commissionFrom(dynamic response) =>
      requireDataMap(response).map(MemberCommissionModel.fromJson);
}
