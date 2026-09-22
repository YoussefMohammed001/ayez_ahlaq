import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../entities/home_service_request_status.dart';
import '../repos/i_barber_home_service_request_repo.dart';

class GetHomeServiceRequestsUseCase {
  final IBarberHomeServiceRequestRepo _repo;

  GetHomeServiceRequestsUseCase(this._repo);

  Future<Either<Failure, List<HomeServiceRequest>>> call({
    HomeServiceRequestStatus? status,
  }) => _repo.getRequests(status: status);
}
