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

  Future<Either<Failure, dynamic>> getCart() {
    return _networkService.getData(endPoint: EndPoints.customerCart);
  }

  Future<Either<Failure, dynamic>> putCart(Map<String, dynamic> body) {
    return _networkService.putData(endPoint: EndPoints.customerCart, data: body);
  }

  Future<Either<Failure, dynamic>> checkout(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.customerCartCheckout,
      data: body,
    );
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
