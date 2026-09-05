import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_device_token_repo.dart';

class RegisterCustomerDeviceTokenUseCase {
  final ICustomerDeviceTokenRepo _repo;

  RegisterCustomerDeviceTokenUseCase(this._repo);

  Future<Either<Failure, Unit>> call(
    String token,
    String platform, {
    double? lat,
    double? lng,
  }) =>
      _repo.register(token, platform, lat: lat, lng: lng);
}
