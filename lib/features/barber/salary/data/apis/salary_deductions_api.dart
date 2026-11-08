import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../../domain/entities/deduction_status.dart';

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

  Future<Either<Failure, dynamic>> list({
    required int page,
    required int size,
    DeductionStatus? status,
    int? barberId,
    String? month,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberSalaryDeduction,
      queryParameters: {
        'page': page,
        'size': size,
        'status': ?status?.wireName,
        'barberId': ?barberId,
        'month': ?month,
      },
    );
  }

  Future<Either<Failure, dynamic>> decide(
    int id, {
    required bool waive,
    String? note,
  }) {
    return _networkService.putData(
      endPoint: '${EndPoints.barberSalaryDeduction}/$id',
      data: {'waive': waive, 'note': ?note},
    );
  }
}
