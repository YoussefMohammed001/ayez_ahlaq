import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../requests/barber_register_request.dart';

class BarberAuthApi {
  final NetworkService _networkService;

  BarberAuthApi(this._networkService);

  Future<Either<Failure, dynamic>> login(String identifier, String password) {
    return _networkService.postData(
      endPoint: EndPoints.barberLogin,
      data: {'identifier': identifier, 'password': password},
    );
  }

  Future<Either<Failure, dynamic>> register(BarberRegisterRequest request) {
    return _networkService.postData(
      endPoint: EndPoints.barberRegister,
      data: request.toJson(),
    );
  }

  Future<Either<Failure, dynamic>> verifyRegisterOtp(String phone, String otp) {
    return _networkService.postData(
      endPoint: EndPoints.barberRegisterVerifyOtp,
      data: {'phoneNumber': phone, 'otp': otp},
    );
  }

  Future<Either<Failure, dynamic>> resendRegisterOtp(String phone) {
    return _networkService.postData(
      endPoint: EndPoints.barberRegisterResendOtp,
      data: {'phoneNumber': phone},
      skipClientHeader: true,
    );
  }

  Future<Either<Failure, dynamic>> forgotPassword(String phone) {
    return _networkService.postData(
      endPoint: EndPoints.barberPasswordForgot,
      data: {'phoneNumber': phone},
    );
  }

  Future<Either<Failure, dynamic>> verifyPasswordOtp(
    String phone,
    String code,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.barberPasswordVerifyOtp,
      data: {'phoneNumber': phone, 'code': code},
    );
  }

  Future<Either<Failure, dynamic>> resetPassword(
    String resetToken,
    String newPassword,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.barberPasswordReset,
      data: {'resetToken': resetToken, 'newPassword': newPassword},
    );
  }
}
