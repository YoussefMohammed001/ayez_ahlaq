import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/working_day.dart';

abstract class IBarberHoursRepo {
  Future<Either<Failure, List<WorkingDay>>> getHours();

  Future<Either<Failure, List<WorkingDay>>> updateHours(List<WorkingDay> days);
}
