import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_barber_home_service_request_repo.dart';

class RejectHomeServiceRequestUseCase {
  final IBarberHomeServiceRequestRepo _repo;

  RejectHomeServiceRequestUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call(int id, String reason) =>
      _repo.reject(id, reason);
}
