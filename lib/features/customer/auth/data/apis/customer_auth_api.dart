import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../requests/customer_register_request.dart';

class CustomerAuthApi {
  final NetworkService _networkService;

  CustomerAuthApi(this._networkService);

  Future<Either<Failure, dynamic>> login(String identifier, String password) {
    return _networkService.postData(
      endPoint: EndPoints.customerLogin,
      data: {'identifier': identifier, 'password': password},
    );
  }

  Future<Either<Failure, dynamic>> register(CustomerRegisterRequest request) {
    return _networkService.postData(
      endPoint: EndPoints.customerRegister,
      data: request.toJson(),
    );
  }
}
