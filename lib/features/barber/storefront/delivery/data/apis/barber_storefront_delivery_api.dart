import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/constants/endpoints.dart';
import '../../../../../../core/network/dio/network_service.dart';

class BarberStorefrontDeliveryApi {
  final NetworkService _networkService;

  BarberStorefrontDeliveryApi(this._networkService);

  Future<Either<Failure, dynamic>> getDelivery() {
    return _networkService.getData(
      endPoint: EndPoints.barberStorefrontDelivery,
    );
  }

  Future<Either<Failure, dynamic>> updateDelivery(Map<String, dynamic> body) {
    return _networkService.putData(
      endPoint: EndPoints.barberStorefrontDelivery,
      data: body,
    );
  }
}
