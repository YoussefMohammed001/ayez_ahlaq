import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../requests/discount_request.dart';

class MerchantDiscountsApi {
  final NetworkService _networkService;

  MerchantDiscountsApi(this._networkService);

  Future<Either<Failure, dynamic>> getDiscounts() {
    return _networkService.getData(endPoint: EndPoints.merchantDiscount);
  }

  Future<Either<Failure, dynamic>> getShops() {
    return _networkService.getData(endPoint: EndPoints.merchantDiscountShop);
  }

  Future<Either<Failure, dynamic>> createDiscount(DiscountRequest request) {
    return _networkService.postData(
      endPoint: EndPoints.merchantDiscount,
      data: request.toJson(),
    );
  }

  Future<Either<Failure, dynamic>> updateDiscount(
    int id,
    DiscountRequest request,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.merchantDiscountById(id),
      data: request.toJson(),
    );
  }

  Future<Either<Failure, dynamic>> closeDiscount(int id) {
    return _networkService.putData(
      endPoint: EndPoints.merchantDiscountClose(id),
    );
  }
}
