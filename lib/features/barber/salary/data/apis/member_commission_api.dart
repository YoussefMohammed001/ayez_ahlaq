import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MemberCommissionApi {
  final NetworkService _networkService;

  MemberCommissionApi(this._networkService);

  Future<Either<Failure, dynamic>> get(int memberId) {
    return _networkService.getData(
      endPoint: EndPoints.barberTeamCommission(memberId),
    );
  }

  Future<Either<Failure, dynamic>> set(
    int memberId, {
    required bool enabled,
    double? percent,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamCommission(memberId),
      data: {'enabled': enabled, 'percent': ?percent},
    );
  }
}
