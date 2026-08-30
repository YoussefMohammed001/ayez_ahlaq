import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantProfileApi {
  final NetworkService _networkService;

  MerchantProfileApi(this._networkService);

  Future<Either<Failure, dynamic>> getProfile() {
    return _networkService.getData(endPoint: EndPoints.merchantProfile);
  }

  Future<Either<Failure, dynamic>> updateProfile(Map<String, dynamic> body) {
    return _networkService.putData(
      endPoint: EndPoints.merchantProfile,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> getPhones() {
    return _networkService.getData(endPoint: EndPoints.merchantPhone);
  }

  Future<Either<Failure, dynamic>> addPhone(String phone, String? label) {
    return _networkService.postData(
      endPoint: EndPoints.merchantPhone,
      data: {
        'phoneNumber': phone,
        if (label != null && label.isNotEmpty) 'label': label,
      },
    );
  }

  Future<Either<Failure, dynamic>> deletePhone(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantPhoneById(id),
    );
  }

  Future<Either<Failure, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.merchantPassword,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }
}
