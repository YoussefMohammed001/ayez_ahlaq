import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberTeamHoursApi {
  final NetworkService _networkService;

  BarberTeamHoursApi(this._networkService);

  Future<Either<Failure, dynamic>> getHours(int memberId) {
    return _networkService.getData(
      endPoint: EndPoints.barberTeamHours(memberId),
    );
  }

  Future<Either<Failure, dynamic>> updateHours(
    int memberId,
    List<Map<String, dynamic>> days,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamHours(memberId),
      data: {'days': days},
    );
  }
}
