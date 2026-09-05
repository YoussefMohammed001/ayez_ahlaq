import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../repos/i_customer_auth_repo.dart';

class CustomerLoginUseCase {
  final ICustomerAuthRepo _repo;

  CustomerLoginUseCase(this._repo);

  Future<Either<Failure, AuthSession>> call(
    String identifier,
    String password,
  ) => _repo.login(identifier, password);
}
