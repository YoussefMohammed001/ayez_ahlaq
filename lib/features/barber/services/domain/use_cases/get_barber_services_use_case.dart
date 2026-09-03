import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_service.dart';
import '../repos/i_barber_services_repo.dart';

class GetBarberServicesUseCase {
  final IBarberServicesRepo _repo;

  GetBarberServicesUseCase(this._repo);

  Future<Either<Failure, List<BarberService>>> call() => _repo.getServices();
}
