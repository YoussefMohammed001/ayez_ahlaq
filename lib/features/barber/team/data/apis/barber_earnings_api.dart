import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberEarningsApi {
  final NetworkService _networkService;

  BarberEarningsApi(this._networkService);

  Future<Either<Failure, dynamic>> getEarnings() {
    return _networkService.getData(endPoint: EndPoints.barberEarnings);
  }

  Future<Either<Failure, dynamic>> getMemberEarnings(int memberId) {
    return _networkService.getData(
      endPoint: EndPoints.barberTeamMemberEarnings(memberId),
    );
  }

  Future<Either<Failure, dynamic>> getMemberClients(
    int memberId, {
    required String from,
    required String to,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberTeamMemberClients(memberId),
      queryParameters: {'from': from, 'to': to},
    );
  }
}
