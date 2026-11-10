import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../repos/i_merchant_team_hours_repo.dart';

class UpdateMerchantMemberHoursUseCase {
  final IMerchantTeamHoursRepo _repo;

  UpdateMerchantMemberHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call(
    int memberId,
    List<WorkingDay> days,
  ) => _repo.updateHours(memberId, days);
}
