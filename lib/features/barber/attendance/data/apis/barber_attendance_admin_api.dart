import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberAttendanceAdminApi {
  final NetworkService _networkService;

  BarberAttendanceAdminApi(this._networkService);

  Future<Either<Failure, dynamic>> getSettings() {
    return _networkService.getData(endPoint: EndPoints.barberAttendanceSetting);
  }

  Future<Either<Failure, dynamic>> updateSettings({
    required bool enforced,
    int? rangeMeters,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.barberAttendanceSetting,
      data: {'enforced': enforced, 'rangeMeters': ?rangeMeters},
    );
  }

  Future<Either<Failure, dynamic>> getTeam() {
    return _networkService.getData(endPoint: EndPoints.barberAttendanceTeam);
  }

  Future<Either<Failure, dynamic>> getSettingLog({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberAttendanceSettingLog,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> correctRecord({
    required int id,
    required String checkInAt,
    required String checkOutAt,
    required String note,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.barberAttendanceById(id),
      data: {'checkInAt': checkInAt, 'checkOutAt': checkOutAt, 'note': note},
    );
  }
}
