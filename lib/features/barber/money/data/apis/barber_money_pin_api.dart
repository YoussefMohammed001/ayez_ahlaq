import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberMoneyPinApi {
  final NetworkService _networkService;

  BarberMoneyPinApi(this._networkService);

  Future<Either<Failure, dynamic>> getStatus() {
    return _networkService.getData(endPoint: EndPoints.barberMoneyPin);
  }

  Future<Either<Failure, dynamic>> setup(String pin) {
    return _networkService.postData(
      endPoint: EndPoints.barberMoneyPin,
      data: {'pin': pin},
    );
  }

  Future<Either<Failure, dynamic>> verify(String pin) {
    return _networkService.postData(
      endPoint: EndPoints.barberMoneyPinVerify,
      data: {'pin': pin},
    );
  }

  Future<Either<Failure, dynamic>> change({
    required String currentPin,
    required String newPin,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.barberMoneyPin,
      data: {'currentPin': currentPin, 'newPin': newPin},
    );
  }

  Future<Either<Failure, dynamic>> getResetRequestStatus() {
    return _networkService.getData(
      endPoint: EndPoints.barberMoneyPinResetRequest,
    );
  }

  Future<Either<Failure, dynamic>> sendResetRequest() {
    return _networkService.postData(
      endPoint: EndPoints.barberMoneyPinResetRequest,
    );
  }
}
