import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_device_token_repo.dart';

class UnregisterAllCustomerDeviceTokensUseCase {
  final ICustomerDeviceTokenRepo _repo;

  UnregisterAllCustomerDeviceTokensUseCase(this._repo);

  Future<Either<Failure, Unit>> call() => _repo.unregisterAll();
}
