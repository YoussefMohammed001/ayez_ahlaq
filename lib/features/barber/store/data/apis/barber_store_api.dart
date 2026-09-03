import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberStoreApi {
  final NetworkService _networkService;

  BarberStoreApi(this._networkService);

  Future<Either<Failure, dynamic>> getMerchants() {
    return _networkService.getData(endPoint: EndPoints.barberStoreMerchant);
  }

  Future<Either<Failure, dynamic>> getMerchantProducts(int merchantId) {
    return _networkService.getData(
      endPoint: EndPoints.barberStoreMerchantProducts(merchantId),
    );
  }

  Future<Either<Failure, dynamic>> quoteCart(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.barberStoreQuote,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> placeOrder(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.barberOrder,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> getOrders() {
    return _networkService.getData(endPoint: EndPoints.barberOrder);
  }

  Future<Either<Failure, dynamic>> getOrderById(int id) {
    return _networkService.getData(endPoint: EndPoints.barberOrderById(id));
  }

  Future<Either<Failure, dynamic>> cancelOrder(int id) {
    return _networkService.putData(endPoint: EndPoints.barberOrderCancel(id));
  }
}
