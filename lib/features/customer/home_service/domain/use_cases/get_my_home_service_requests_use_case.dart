import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_customer_home_service_repo.dart';

class GetMyHomeServiceRequestsUseCase {
  final ICustomerHomeServiceRepo _repo;

  GetMyHomeServiceRequestsUseCase(this._repo);

  Future<Either<Failure, List<HomeServiceRequest>>> call() =>
      _repo.getMyRequests();
}
