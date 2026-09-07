import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/customer_register_request.dart';
import '../repos/i_customer_auth_repo.dart';

class CustomerRegisterUseCase {
  final ICustomerAuthRepo _repo;

  CustomerRegisterUseCase(this._repo);

  Future<Either<Failure, Unit>> call(CustomerRegisterRequest request) =>
      _repo.register(request);
}
