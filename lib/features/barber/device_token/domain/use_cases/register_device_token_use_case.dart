import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_device_token_repo.dart';

class RegisterDeviceTokenUseCase {
  final IBarberDeviceTokenRepo _repo;

  RegisterDeviceTokenUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String token, String platform) =>
      _repo.register(token, platform);
}
