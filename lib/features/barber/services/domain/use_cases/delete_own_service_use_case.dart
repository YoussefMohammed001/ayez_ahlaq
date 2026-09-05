import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_services_repo.dart';

class DeleteOwnServiceUseCase {
  final IBarberServicesRepo _repo;

  DeleteOwnServiceUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteOwnService(id);
}
