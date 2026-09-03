import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../hours/domain/entities/working_day.dart';
import '../repos/i_barber_team_hours_repo.dart';

class GetMemberHoursUseCase {
  final IBarberTeamHoursRepo _repo;

  GetMemberHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call(int memberId) =>
      _repo.getHours(memberId);
}
