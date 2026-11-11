import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../../../../barber/attendance/domain/entities/attendance_method.dart';

class MerchantAttendanceApi {
  final NetworkService _networkService;

  MerchantAttendanceApi(this._networkService);

  Future<Either<Failure, dynamic>> getCurrent() {
    return _networkService.getData(
      endPoint: EndPoints.merchantMemberMeAttendanceCurrent,
    );
  }

  Future<Either<Failure, dynamic>> checkIn({
    double? lat,
    double? lng,
    required AttendanceMethod method,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.merchantMemberMeCheckIn,
      data: {'lat': lat, 'lng': lng, 'method': method.wireName},
    );
  }

  Future<Either<Failure, dynamic>> checkOut({
    double? lat,
    double? lng,
    required AttendanceMethod method,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.merchantMemberMeCheckOut,
      data: {'lat': lat, 'lng': lng, 'method': method.wireName},
    );
  }

  Future<Either<Failure, dynamic>> getHistory({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantMemberMeAttendance,
      queryParameters: {'page': page, 'size': size},
    );
  }
}
