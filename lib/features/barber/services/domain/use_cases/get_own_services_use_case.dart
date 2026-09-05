import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/own_service.dart';
import '../repos/i_barber_services_repo.dart';

class GetOwnServicesUseCase {
  final IBarberServicesRepo _repo;

  GetOwnServicesUseCase(this._repo);

  Future<Either<Failure, List<OwnService>>> call() => _repo.getOwnServices();
}
