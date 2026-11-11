import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantSalesApi {
  final NetworkService _networkService;

  MerchantSalesApi(this._networkService);

  Future<Either<Failure, dynamic>> createSale(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.merchantSale,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> getSales({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantSale,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> cancelSale(int id) {
    return _networkService.putData(
      endPoint: EndPoints.merchantSaleCancel(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> getPaymentMethods() {
    return _networkService.getData(endPoint: EndPoints.merchantPaymentMethod);
  }
}
