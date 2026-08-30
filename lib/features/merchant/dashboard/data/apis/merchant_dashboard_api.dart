import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantDashboardApi {
  final NetworkService _networkService;

  MerchantDashboardApi(this._networkService);

  Future<Either<Failure, dynamic>> getDashboard() {
    return _networkService.getData(endPoint: EndPoints.merchantDashboard);
  }
}
