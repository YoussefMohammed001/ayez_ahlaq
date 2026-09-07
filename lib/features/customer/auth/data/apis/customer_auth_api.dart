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

  Future<Either<Failure, dynamic>> verifyRegisterOtp(String phone, String otp) {
    return _networkService.postData(
      endPoint: EndPoints.customerRegisterVerifyOtp,
      data: {'phoneNumber': phone, 'otp': otp},
    );
  }

  Future<Either<Failure, dynamic>> resendRegisterOtp(String phone) {
    return _networkService.postData(
      endPoint: EndPoints.customerRegisterResendOtp,
      data: {'phoneNumber': phone},
    );
  }

  Future<Either<Failure, dynamic>> forgotPassword(String phone) {
    return _networkService.postData(
      endPoint: EndPoints.customerPasswordForgot,
      data: {'phoneNumber': phone},
    );
  }

  Future<Either<Failure, dynamic>> verifyPasswordOtp(
    String phone,
    String code,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.customerPasswordVerifyOtp,
      data: {'phoneNumber': phone, 'code': code},
    );
  }

  Future<Either<Failure, dynamic>> resetPassword(
    String resetToken,
    String newPassword,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.customerPasswordReset,
      data: {'resetToken': resetToken, 'newPassword': newPassword},
    );
  }
}
