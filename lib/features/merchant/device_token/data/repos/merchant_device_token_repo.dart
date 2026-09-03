import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/repos/i_merchant_device_token_repo.dart';
import '../apis/merchant_device_token_api.dart';

class MerchantDeviceTokenRepo implements IMerchantDeviceTokenRepo {
  final MerchantDeviceTokenApi _api;

  MerchantDeviceTokenRepo(this._api);

  @override
  Future<Either<Failure, Unit>> register(String token, String platform) async {
    final result = await _api.register(token, platform);
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
