import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/working_day.dart';
import '../repos/i_barber_hours_repo.dart';

class UpdateBarberHoursUseCase {
  final IBarberHoursRepo _repo;

  UpdateBarberHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call(List<WorkingDay> days) =>
      _repo.updateHours(days);
}
