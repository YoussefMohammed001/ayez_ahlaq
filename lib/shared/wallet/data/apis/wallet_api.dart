import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../wallet_endpoints.dart';
import '../../../../core/network/dio/network_service.dart';

class WalletApi {
  final NetworkService _networkService;
  final WalletEndpoints _endpoints;

  WalletApi(this._networkService, this._endpoints);

  Future<Either<Failure, dynamic>> getWallet() {
    return _networkService.getData(endPoint: _endpoints.wallet);
  }
}
