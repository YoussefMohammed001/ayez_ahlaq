import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../requests/register_request.dart';

class MerchantAuthApi {
  final NetworkService _networkService;

  MerchantAuthApi(this._networkService);

  Future<Either<Failure, dynamic>> login(String phone, String password) {
    return _networkService.postData(
      endPoint: EndPoints.merchantLogin,
      data: {'phoneNumber': phone, 'password': password},
    );
  }

  Future<Either<Failure, dynamic>> register(RegisterRequest request) {
    return _networkService.postData(
      endPoint: EndPoints.merchantRegister,
      data: request.toJson(),
    );
  }
}
