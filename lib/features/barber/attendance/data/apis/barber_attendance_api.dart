import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../../domain/entities/attendance_method.dart';

class BarberAttendanceApi {
  final NetworkService _networkService;

  BarberAttendanceApi(this._networkService);

  Future<Either<Failure, dynamic>> getCurrent() {
    return _networkService.getData(endPoint: EndPoints.barberAttendanceCurrent);
  }

  Future<Either<Failure, dynamic>> checkIn({
    double? lat,
    double? lng,
    required AttendanceMethod method,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.barberAttendanceCheckIn,
      data: {'lat': lat, 'lng': lng, 'method': method.wireName},
    );
  }

  Future<Either<Failure, dynamic>> checkOut({
    double? lat,
    double? lng,
    required AttendanceMethod method,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.barberAttendanceCheckOut,
      data: {'lat': lat, 'lng': lng, 'method': method.wireName},
    );
  }

  Future<Either<Failure, dynamic>> getHistory({
    required int page,
    required int size,
    DateTime? from,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberAttendance,
      queryParameters: {
        'page': page,
        'size': size,
        if (from != null) 'from': _dateOnly(from),
      },
    );
  }

  static String _dateOnly(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
