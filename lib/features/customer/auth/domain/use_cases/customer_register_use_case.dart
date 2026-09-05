import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../../data/requests/customer_register_request.dart';
import '../repos/i_customer_auth_repo.dart';

class CustomerRegisterUseCase {
  final ICustomerAuthRepo _repo;

  CustomerRegisterUseCase(this._repo);

  Future<Either<Failure, AuthSession>> call(CustomerRegisterRequest request) =>
      _repo.register(request);
}
