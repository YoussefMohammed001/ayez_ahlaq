import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../hours/domain/entities/working_day.dart';
import '../repos/i_barber_home_service_hours_repo.dart';

class GetHomeServiceHoursUseCase {
  final IBarberHomeServiceHoursRepo _repo;

  GetHomeServiceHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call() => _repo.getHours();
}
