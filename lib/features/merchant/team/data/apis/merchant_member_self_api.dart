import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantMemberSelfApi {
  final NetworkService _networkService;

  MerchantMemberSelfApi(this._networkService);

  Future<Either<Failure, dynamic>> getMe() {
    return _networkService.getData(endPoint: EndPoints.merchantMemberMe);
  }

  Future<Either<Failure, dynamic>> getMyHours() {
    return _networkService.getData(endPoint: EndPoints.merchantMemberMeHours);
  }

  Future<Either<Failure, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberMePassword,
      data: {'currentPassword': currentPassword, 'newPassword': newPassword},
    );
  }
}
