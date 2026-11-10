import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../repos/i_merchant_team_hours_repo.dart';

class GetMerchantMemberHoursUseCase {
  final IMerchantTeamHoursRepo _repo;

  GetMerchantMemberHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call(int memberId) =>
      _repo.getHours(memberId);
}
