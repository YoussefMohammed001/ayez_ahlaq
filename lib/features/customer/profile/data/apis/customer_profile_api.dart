import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerProfileApi {
  final NetworkService _networkService;

  CustomerProfileApi(this._networkService);

  Future<Either<Failure, dynamic>> getProfile() {
    return _networkService.getData(endPoint: EndPoints.customerMe);
  }

  Future<Either<Failure, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.customerPassword,
      data: {'currentPassword': currentPassword, 'newPassword': newPassword},
    );
  }

  Future<Either<Failure, dynamic>> deleteAccount(String password) {
    return _networkService.deleteData(
      endPoint: EndPoints.customerMe,
      data: {'password': password},
    );
  }
}
