import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class SalaryDeductionsApi {
  final NetworkService _networkService;

  SalaryDeductionsApi(this._networkService);

  Future<Either<Failure, dynamic>> pendingCount() {
    return _networkService.getData(
      endPoint: EndPoints.barberSalaryDeductionPendingCount,
    );
  }

  Future<Either<Failure, dynamic>> getSetting() {
    return _networkService.getData(
      endPoint: EndPoints.barberSalaryDeductionSetting,
    );
  }

  Future<Either<Failure, dynamic>> setSetting(int graceMinutes) {
    return _networkService.putData(
      endPoint: EndPoints.barberSalaryDeductionSetting,
      data: {'graceMinutes': graceMinutes},
    );
  }
}
