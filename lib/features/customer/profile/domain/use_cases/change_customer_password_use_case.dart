import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_profile_repo.dart';

class ChangeCustomerPasswordUseCase {
  final ICustomerProfileRepo _repo;

  ChangeCustomerPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(
    String currentPassword,
    String newPassword,
  ) => _repo.changePassword(currentPassword, newPassword);
}
