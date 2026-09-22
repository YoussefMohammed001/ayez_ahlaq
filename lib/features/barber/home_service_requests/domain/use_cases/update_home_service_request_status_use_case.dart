import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../entities/home_service_request_status.dart';
import '../repos/i_barber_home_service_request_repo.dart';

class UpdateHomeServiceRequestStatusUseCase {
  final IBarberHomeServiceRequestRepo _repo;

  UpdateHomeServiceRequestStatusUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call(
    int id,
    HomeServiceRequestStatus status,
  ) => _repo.updateStatus(id, status);
}
