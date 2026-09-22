import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../requests/barber_discount_request.dart';

class BarberDiscountsApi {
  final NetworkService _networkService;

  BarberDiscountsApi(this._networkService);

  Future<Either<Failure, dynamic>> getDiscounts() {
    return _networkService.getData(endPoint: EndPoints.barberDiscount);
  }

  Future<Either<Failure, dynamic>> getDiscountById(int id) {
    return _networkService.getData(endPoint: EndPoints.barberDiscountById(id));
  }

  Future<Either<Failure, dynamic>> createDiscount(BarberDiscountRequest request) {
    return _networkService.postData(
      endPoint: EndPoints.barberDiscount,
      data: request.toJson(),
    );
  }

  Future<Either<Failure, dynamic>> updateDiscount(
    int id,
    BarberDiscountRequest request,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberDiscountById(id),
      data: request.toJson(),
    );
  }

  Future<Either<Failure, dynamic>> closeDiscount(int id) {
    return _networkService.putData(endPoint: EndPoints.barberDiscountClose(id));
  }
}
