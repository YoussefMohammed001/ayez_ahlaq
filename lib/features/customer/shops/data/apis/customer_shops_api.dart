import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerShopsApi {
  final NetworkService _networkService;

  CustomerShopsApi(this._networkService);

  Future<Either<Failure, dynamic>> getShops({double? lat, double? lng}) {
    return _networkService.getData(
      endPoint: EndPoints.customerShop,
      queryParameters: lat == null || lng == null
          ? null
          : {'lat': lat, 'lng': lng},
    );
  }

  Future<Either<Failure, dynamic>> getShopDetail(int shopId) {
    return _networkService.getData(
      endPoint: EndPoints.customerShopById(shopId),
    );
  }
}
