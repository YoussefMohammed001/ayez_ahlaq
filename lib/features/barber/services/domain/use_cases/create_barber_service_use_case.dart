import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_service.dart';
import '../repos/i_barber_services_repo.dart';

class CreateBarberServiceUseCase {
  final IBarberServicesRepo _repo;

  CreateBarberServiceUseCase(this._repo);

  Future<Either<Failure, BarberService>> call(BarberService service) =>
      _repo.createService(service);
}
