import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerHomeServiceApi {
  final NetworkService _networkService;

  CustomerHomeServiceApi(this._networkService);

  Future<Either<Failure, dynamic>> getShops({
    required String date,
    required String time,
    double? lat,
    double? lng,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.customerHomeServiceShop,
      queryParameters: {
        'date': date,
        'time': time,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      },
    );
  }

  Future<Either<Failure, dynamic>> getHours(int shopId) {
    return _networkService.getData(
      endPoint: EndPoints.customerHomeServiceHours(shopId),
    );
  }

  Future<Either<Failure, dynamic>> createRequest({
    int? shopId,
    bool anyNearby = false,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.customerHomeService,
      data: {
        if (anyNearby) 'anyNearby': true else 'shopId': shopId,
        'address': address,
        'lat': lat,
        'lng': lng,
        'note': note,
        'date': date,
        'time': time,
      },
    );
  }

  Future<Either<Failure, dynamic>> retryRequest({
    required int id,
    int? shopId,
    bool anyNearby = false,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.customerHomeServiceRetry(id),
      data: {
        if (anyNearby) 'anyNearby': true else 'shopId': shopId,
        'address': address,
        'lat': lat,
        'lng': lng,
        'note': note,
        'date': date,
        'time': time,
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

  Future<Either<Failure, dynamic>> rate(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.customerRating,
      data: body,
    );
  }
}
