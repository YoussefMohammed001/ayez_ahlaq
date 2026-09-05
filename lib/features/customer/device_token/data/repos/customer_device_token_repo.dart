import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/repos/i_customer_device_token_repo.dart';
import '../apis/customer_device_token_api.dart';

class CustomerDeviceTokenRepo implements ICustomerDeviceTokenRepo {
  final CustomerDeviceTokenApi _api;

  CustomerDeviceTokenRepo(this._api);

  @override
  Future<Either<Failure, Unit>> register(
    String token,
    String platform, {
    double? lat,
    double? lng,
  }) async {
    final result = await _api.register(token, platform, lat: lat, lng: lng);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> unregister(String token) async {
    final result = await _api.unregister(token);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> unregisterAll() async {
    final result = await _api.unregisterAll();
    return result.map((_) => unit);
  }
}
