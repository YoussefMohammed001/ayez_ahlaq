import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_profile.dart';
import '../repos/i_customer_profile_repo.dart';

class GetCustomerProfileUseCase {
  final ICustomerProfileRepo _repo;

  GetCustomerProfileUseCase(this._repo);

  Future<Either<Failure, CustomerProfile>> call() => _repo.getProfile();
}
