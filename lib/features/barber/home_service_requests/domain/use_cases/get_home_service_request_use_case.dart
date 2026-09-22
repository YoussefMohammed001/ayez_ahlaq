import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_barber_home_service_request_repo.dart';

class GetHomeServiceRequestUseCase {
  final IBarberHomeServiceRequestRepo _repo;

  GetHomeServiceRequestUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call(int id) =>
      _repo.getRequest(id);
}
