import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/constants/endpoints.dart';
import '../../../../../../core/network/dio/network_service.dart';
import '../../domain/entities/storefront_order_status.dart';

class BarberStorefrontOrdersApi {
  final NetworkService _networkService;

  BarberStorefrontOrdersApi(this._networkService);

  Future<Either<Failure, dynamic>> getOrders() {
    return _networkService.getData(endPoint: EndPoints.barberStorefrontOrder);
  }

  Future<Either<Failure, dynamic>> getOrder(int id) {
    return _networkService.getData(
      endPoint: EndPoints.barberStorefrontOrderById(id),
    );
  }

  Future<Either<Failure, dynamic>> acceptOrder(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberStorefrontOrderAccept(id),
    );
  }

  Future<Either<Failure, dynamic>> rejectOrder(int id, String reason) {
    return _networkService.putData(
      endPoint: EndPoints.barberStorefrontOrderReject(id),
      data: {'reason': reason},
    );
  }

  Future<Either<Failure, dynamic>> advanceStatus(
    int id,
    StorefrontOrderStatus status,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberStorefrontOrderStatus(id),
      data: {'status': status.toApi()},
    );
  }
}
