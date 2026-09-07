import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_auth_repo.dart';

class ForgotCustomerPasswordUseCase {
  final ICustomerAuthRepo _repo;

  ForgotCustomerPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String phone) =>
      _repo.forgotPassword(phone);
}
