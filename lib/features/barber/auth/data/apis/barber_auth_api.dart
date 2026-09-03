import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberAuthApi {
  final NetworkService _networkService;

  BarberAuthApi(this._networkService);

  Future<Either<Failure, dynamic>> login(String identifier, String password) {
    return _networkService.postData(
      endPoint: EndPoints.barberLogin,
      data: {'identifier': identifier, 'password': password},
    );
  }
}
