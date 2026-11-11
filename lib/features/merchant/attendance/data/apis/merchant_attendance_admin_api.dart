import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantAttendanceAdminApi {
  final NetworkService _networkService;

  MerchantAttendanceAdminApi(this._networkService);

  Future<Either<Failure, dynamic>> getSettings() {
    return _networkService.getData(
      endPoint: EndPoints.merchantMemberAttendanceSetting,
    );
  }

  Future<Either<Failure, dynamic>> updateSettings({
    required bool enforced,
    int? rangeMeters,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberAttendanceSetting,
      data: {'enforced': enforced, 'rangeMeters': ?rangeMeters},
    );
  }

  Future<Either<Failure, dynamic>> getTeam() {
    return _networkService.getData(
      endPoint: EndPoints.merchantMemberAttendanceTeam,
    );
  }

  Future<Either<Failure, dynamic>> getSettingLog({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantMemberAttendanceSettingLog,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> getMemberHistory({
    required int memberId,
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantMemberAttendanceOf(memberId),
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
      endPoint: EndPoints.merchantMemberAttendanceById(id),
      data: {'checkInAt': checkInAt, 'checkOutAt': checkOutAt, 'note': note},
    );
  }
}
