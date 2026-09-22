import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerHomeServiceApi {
  final NetworkService _networkService;

  CustomerHomeServiceApi(this._networkService);

  Future<Either<Failure, dynamic>> getShops({double? lat, double? lng}) {
    return _networkService.getData(
      endPoint: EndPoints.customerHomeServiceShop,
      queryParameters: lat == null || lng == null
          ? null
          : {'lat': lat, 'lng': lng},
    );
  }

  Future<Either<Failure, dynamic>> getHours(int shopId) {
    return _networkService.getData(
      endPoint: EndPoints.customerHomeServiceHours(shopId),
    );
  }

  Future<Either<Failure, dynamic>> createRequest({
    required int shopId,
    required String address,
    required double lat,
    required double lng,
    String? note,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.customerHomeService,
      data: {
        'shopId': shopId,
        'address': address,
        'lat': lat,
        'lng': lng,
        'note': note,
      },
    );
  }

  Future<Either<Failure, dynamic>> getMyRequests() {
    return _networkService.getData(endPoint: EndPoints.customerHomeService);
  }

  Future<Either<Failure, dynamic>> getRequest(int id) {
    return _networkService.getData(
      endPoint: EndPoints.customerHomeServiceById(id),
    );
  }

  Future<Either<Failure, dynamic>> confirmPrice(int id) {
    return _networkService.putData(
      endPoint: EndPoints.customerHomeServiceConfirmPrice(id),
    );
  }

  Future<Either<Failure, dynamic>> cancel(int id) {
    return _networkService.putData(
      endPoint: EndPoints.customerHomeServiceCancel(id),
    );
  }
}
