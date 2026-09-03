import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantDeviceTokenApi {
  final NetworkService _networkService;

  MerchantDeviceTokenApi(this._networkService);

  Future<Either<Failure, dynamic>> register(String token, String platform) {
    return _networkService.postData(
      endPoint: EndPoints.merchantDeviceToken,
      data: {'token': token, 'platform': platform},
    );
  }

  Future<Either<Failure, dynamic>> unregister(String token) {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantDeviceToken,
      data: {'token': token},
    );
  }

  Future<Either<Failure, dynamic>> unregisterAll() {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantDeviceTokenAll,
    );
  }
}
