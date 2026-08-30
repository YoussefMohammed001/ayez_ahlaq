import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../../domain/entities/order_status.dart';

class MerchantOrdersApi {
  final NetworkService _networkService;

  MerchantOrdersApi(this._networkService);

  Future<Either<Failure, dynamic>> getOrders({OrderStatus? status}) {
    return _networkService.getData(
      endPoint: EndPoints.merchantOrder,
      queryParameters: status == null ? null : {'status': status.toApi()},
    );
  }

  Future<Either<Failure, dynamic>> getOrder(int id) {
    return _networkService.getData(endPoint: EndPoints.merchantOrderById(id));
  }

  Future<Either<Failure, dynamic>> acceptOrder(int id) {
    return _networkService.putData(endPoint: EndPoints.merchantOrderAccept(id));
  }

  Future<Either<Failure, dynamic>> rejectOrder(int id, String reason) {
    return _networkService.putData(
      endPoint: EndPoints.merchantOrderReject(id),
      data: {'reason': reason},
    );
  }

  Future<Either<Failure, dynamic>> advanceStatus(int id, OrderStatus status) {
    return _networkService.putData(
      endPoint: EndPoints.merchantOrderStatus(id),
      data: {'status': status.toApi()},
    );
  }
}
