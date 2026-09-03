import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_services_repo.dart';

class DeleteBarberServiceUseCase {
  final IBarberServicesRepo _repo;

  DeleteBarberServiceUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteService(id);
}
