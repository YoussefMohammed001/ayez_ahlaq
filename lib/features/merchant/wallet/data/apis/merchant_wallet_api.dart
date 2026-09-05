import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantWalletApi {
  final NetworkService _networkService;

  MerchantWalletApi(this._networkService);

  Future<Either<Failure, dynamic>> getWallet() {
    return _networkService.getData(endPoint: EndPoints.merchantWallet);
  }
}
