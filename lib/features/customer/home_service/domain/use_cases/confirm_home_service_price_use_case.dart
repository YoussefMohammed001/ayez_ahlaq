import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_customer_home_service_repo.dart';

class ConfirmHomeServicePriceUseCase {
  final ICustomerHomeServiceRepo _repo;

  ConfirmHomeServicePriceUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call(int id) =>
      _repo.confirmPrice(id);
}
