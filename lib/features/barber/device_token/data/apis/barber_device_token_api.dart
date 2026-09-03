import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberDeviceTokenApi {
  final NetworkService _networkService;

  BarberDeviceTokenApi(this._networkService);

  Future<Either<Failure, dynamic>> register(String token, String platform) {
    return _networkService.postData(
      endPoint: EndPoints.barberDeviceToken,
      data: {'token': token, 'platform': platform},
    );
  }

  Future<Either<Failure, dynamic>> unregister(String token) {
    return _networkService.deleteData(
      endPoint: EndPoints.barberDeviceToken,
      data: {'token': token},
    );
  }

  Future<Either<Failure, dynamic>> unregisterAll() {
    return _networkService.deleteData(
      endPoint: EndPoints.barberDeviceTokenAll,
    );
  }
}
