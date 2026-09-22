import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_customer_home_service_repo.dart';

class CancelHomeServiceRequestUseCase {
  final ICustomerHomeServiceRepo _repo;

  CancelHomeServiceRequestUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call(int id) => _repo.cancel(id);
}
