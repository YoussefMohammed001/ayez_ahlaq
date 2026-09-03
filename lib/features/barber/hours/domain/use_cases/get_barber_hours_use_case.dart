import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/working_day.dart';
import '../repos/i_barber_hours_repo.dart';

class GetBarberHoursUseCase {
  final IBarberHoursRepo _repo;

  GetBarberHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call() => _repo.getHours();
}
