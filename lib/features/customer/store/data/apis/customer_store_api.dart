import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerStoreApi {
  final NetworkService _networkService;

  CustomerStoreApi(this._networkService);

  Future<Either<Failure, dynamic>> getStorefront(int shopId) {
    return _networkService.getData(
      endPoint: EndPoints.customerShopStorefront(shopId),
    );
  }

  Future<Either<Failure, dynamic>> quoteCart(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.customerStoreQuote,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> placeOrder(Map<String, dynamic> body) {
    return _networkService.postData(endPoint: EndPoints.customerOrder, data: body);
  }

  Future<Either<Failure, dynamic>> getOrders() {
    return _networkService.getData(endPoint: EndPoints.customerOrder);
  }

  Future<Either<Failure, dynamic>> getOrder(int id) {
    return _networkService.getData(endPoint: EndPoints.customerOrderById(id));
  }

  Future<Either<Failure, dynamic>> cancelOrder(int id) {
    return _networkService.putData(endPoint: EndPoints.customerOrderCancel(id));
  }
}
