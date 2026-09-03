import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberProfileApi {
  final NetworkService _networkService;

  BarberProfileApi(this._networkService);

  Future<Either<Failure, dynamic>> getProfile() {
    return _networkService.getData(endPoint: EndPoints.barberMe);
  }

  Future<Either<Failure, dynamic>> updateLocation(Map<String, dynamic> body) {
    return _networkService.putData(
      endPoint: EndPoints.barberLocation,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberPassword,
      data: {'currentPassword': currentPassword, 'newPassword': newPassword},
    );
  }
}
