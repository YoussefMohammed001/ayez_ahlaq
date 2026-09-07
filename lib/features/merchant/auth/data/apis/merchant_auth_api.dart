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

  Future<Either<Failure, dynamic>> verifyRegisterOtp(String phone, String otp) {
    return _networkService.postData(
      endPoint: EndPoints.merchantRegisterVerifyOtp,
      data: {'phoneNumber': phone, 'otp': otp},
    );
  }

  Future<Either<Failure, dynamic>> resendRegisterOtp(String phone) {
    return _networkService.postData(
      endPoint: EndPoints.merchantRegisterResendOtp,
      data: {'phoneNumber': phone},
    );
  }

  Future<Either<Failure, dynamic>> forgotPassword(String phone) {
    return _networkService.postData(
      endPoint: EndPoints.merchantPasswordForgot,
      data: {'phoneNumber': phone},
    );
  }

  Future<Either<Failure, dynamic>> verifyPasswordOtp(
    String phone,
    String code,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.merchantPasswordVerifyOtp,
      data: {'phoneNumber': phone, 'code': code},
    );
  }

  Future<Either<Failure, dynamic>> resetPassword(
    String resetToken,
    String newPassword,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.merchantPasswordReset,
      data: {'resetToken': resetToken, 'newPassword': newPassword},
    );
  }
}
