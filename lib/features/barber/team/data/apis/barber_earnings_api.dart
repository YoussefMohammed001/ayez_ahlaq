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
}
