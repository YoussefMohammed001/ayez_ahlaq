import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_device_token_repo.dart';

class UnregisterAllDeviceTokensUseCase {
  final IMerchantDeviceTokenRepo _repo;

  UnregisterAllDeviceTokensUseCase(this._repo);

  Future<Either<Failure, Unit>> call() => _repo.unregisterAll();
}
