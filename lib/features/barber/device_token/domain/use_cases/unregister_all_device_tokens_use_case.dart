import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_device_token_repo.dart';

class UnregisterAllDeviceTokensUseCase {
  final IBarberDeviceTokenRepo _repo;

  UnregisterAllDeviceTokensUseCase(this._repo);

  Future<Either<Failure, Unit>> call() => _repo.unregisterAll();
}
