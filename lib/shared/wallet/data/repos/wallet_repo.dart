import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/response_guard.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repos/i_wallet_repo.dart';
import '../apis/wallet_api.dart';
import '../models/wallet_model.dart';

class WalletRepo implements IWalletRepo {
  final WalletApi _api;

  WalletRepo(this._api);

  @override
  Future<Either<Failure, Wallet>> getWallet() async {
    final result = await _api.getWallet();
    return result.flatMap(_mapWallet);
  }

  Either<Failure, Wallet> _mapWallet(dynamic response) {
    return requireDataMap(response).map(WalletModel.fromJson);
  }
}
