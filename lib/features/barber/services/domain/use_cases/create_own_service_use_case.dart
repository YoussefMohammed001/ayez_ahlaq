import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/own_service.dart';
import '../repos/i_barber_services_repo.dart';

class CreateOwnServiceUseCase {
  final IBarberServicesRepo _repo;

  CreateOwnServiceUseCase(this._repo);

  Future<Either<Failure, OwnService>> call(String name, String description) =>
      _repo.createOwnService(name, description);
}
