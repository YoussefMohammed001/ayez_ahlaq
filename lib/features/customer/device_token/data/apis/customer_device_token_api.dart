import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerDeviceTokenApi {
  final NetworkService _networkService;

  CustomerDeviceTokenApi(this._networkService);

  Future<Either<Failure, dynamic>> register(
    String token,
    String platform, {
    double? lat,
    double? lng,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.customerDeviceToken,
      data: {
        'token': token,
        'platform': platform,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      },
    );
  }

  Future<Either<Failure, dynamic>> unregister(String token) {
    return _networkService.deleteData(
      endPoint: EndPoints.customerDeviceToken,
      data: {'token': token},
    );
  }

  Future<Either<Failure, dynamic>> unregisterAll() {
    return _networkService.deleteData(endPoint: EndPoints.customerDeviceTokenAll);
  }
}
