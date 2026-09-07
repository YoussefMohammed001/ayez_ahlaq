import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_auth_repo.dart';

class ResetCustomerPasswordUseCase {
  final ICustomerAuthRepo _repo;

  ResetCustomerPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String resetToken, String newPassword) =>
      _repo.resetPassword(resetToken, newPassword);
}
