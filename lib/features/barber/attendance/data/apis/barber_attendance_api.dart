import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberAttendanceApi {
  final NetworkService _networkService;

  BarberAttendanceApi(this._networkService);

  Future<Either<Failure, dynamic>> getCurrent() {
    return _networkService.getData(endPoint: EndPoints.barberAttendanceCurrent);
  }

  Future<Either<Failure, dynamic>> checkIn({double? lat, double? lng}) {
    return _networkService.postData(
      endPoint: EndPoints.barberAttendanceCheckIn,
      data: {'lat': lat, 'lng': lng},
    );
  }

  Future<Either<Failure, dynamic>> checkOut({double? lat, double? lng}) {
    return _networkService.postData(
      endPoint: EndPoints.barberAttendanceCheckOut,
      data: {'lat': lat, 'lng': lng},
    );
  }

  Future<Either<Failure, dynamic>> getHistory({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberAttendance,
      queryParameters: {'page': page, 'size': size},
    );
  }
}
