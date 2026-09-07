import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_profile_repo.dart';

class DeleteCustomerAccountUseCase {
  final ICustomerProfileRepo _repo;

  DeleteCustomerAccountUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String password) =>
      _repo.deleteAccount(password);
}
