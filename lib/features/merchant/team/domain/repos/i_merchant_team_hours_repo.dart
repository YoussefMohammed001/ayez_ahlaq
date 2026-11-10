import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';

abstract class IMerchantTeamHoursRepo {
  Future<Either<Failure, List<WorkingDay>>> getHours(int memberId);

  Future<Either<Failure, List<WorkingDay>>> updateHours(
    int memberId,
    List<WorkingDay> days,
  );
}
