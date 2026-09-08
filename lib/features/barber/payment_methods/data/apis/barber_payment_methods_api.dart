import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberPaymentMethodsApi {
  final NetworkService _networkService;

  BarberPaymentMethodsApi(this._networkService);

  Future<Either<Failure, dynamic>> getEnabledPaymentMethods() {
    return _networkService.getData(endPoint: EndPoints.barberPaymentMethod);
  }
}
