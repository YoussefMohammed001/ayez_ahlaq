import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../hours/domain/entities/working_day.dart';

abstract class IBarberHomeServiceHoursRepo {
  Future<Either<Failure, List<WorkingDay>>> getHours();

  Future<Either<Failure, List<WorkingDay>>> updateHours(List<WorkingDay> days);
}
