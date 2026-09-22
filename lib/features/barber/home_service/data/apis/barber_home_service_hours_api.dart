import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberHomeServiceHoursApi {
  final NetworkService _networkService;

  BarberHomeServiceHoursApi(this._networkService);

  Future<Either<Failure, dynamic>> getHours() {
    return _networkService.getData(
      endPoint: EndPoints.barberHomeServiceHours,
    );
  }

  Future<Either<Failure, dynamic>> updateHours(
    List<Map<String, dynamic>> days,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeServiceHours,
      data: {'days': days},
    );
  }
}
