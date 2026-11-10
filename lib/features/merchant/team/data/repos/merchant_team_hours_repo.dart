import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../barber/hours/data/models/working_day_model.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../../domain/repos/i_merchant_team_hours_repo.dart';
import '../apis/merchant_team_hours_api.dart';

class MerchantTeamHoursRepo implements IMerchantTeamHoursRepo {
  final MerchantTeamHoursApi _api;

  MerchantTeamHoursRepo(this._api);

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours(int memberId) async {
    final result = await _api.getHours(memberId);
    return result.map(_mapMany);
  }

  @override
  Future<Either<Failure, List<WorkingDay>>> updateHours(
    int memberId,
    List<WorkingDay> days,
  ) async {
    final result = await _api.updateHours(
      memberId,
      days.map(WorkingDayModel.toJson).toList(),
    );
    return result.map(_mapMany);
  }

  List<WorkingDay> _mapMany(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => WorkingDayModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
