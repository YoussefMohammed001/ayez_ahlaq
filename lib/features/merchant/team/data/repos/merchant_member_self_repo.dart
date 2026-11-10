import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../barber/hours/data/models/working_day_model.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../../domain/entities/merchant_member.dart';
import '../../domain/repos/i_merchant_member_self_repo.dart';
import '../apis/merchant_member_self_api.dart';
import '../models/merchant_member_model.dart';

class MerchantMemberSelfRepo implements IMerchantMemberSelfRepo {
  final MerchantMemberSelfApi _api;

  MerchantMemberSelfRepo(this._api);

  @override
  Future<Either<Failure, MerchantMember>> getMe() async {
    final result = await _api.getMe();
    return result.flatMap(
      (response) => requireDataMap(response).map(MerchantMemberModel.fromJson),
    );
  }

  @override
  Future<Either<Failure, List<WorkingDay>>> getMyHours() async {
    final result = await _api.getMyHours();
    return result.map(_mapMany);
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final result = await _api.changePassword(currentPassword, newPassword);
    return result.map((_) => unit);
  }

  List<WorkingDay> _mapMany(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => WorkingDayModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
