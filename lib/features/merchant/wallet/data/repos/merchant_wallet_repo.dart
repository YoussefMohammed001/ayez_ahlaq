import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/merchant_wallet.dart';
import '../../domain/repos/i_merchant_wallet_repo.dart';
import '../apis/merchant_wallet_api.dart';
import '../models/merchant_wallet_model.dart';

class MerchantWalletRepo implements IMerchantWalletRepo {
  final MerchantWalletApi _api;

  MerchantWalletRepo(this._api);

  @override
  Future<Either<Failure, MerchantWallet>> getWallet() async {
    final result = await _api.getWallet();
    return result.flatMap(_mapWallet);
  }

  Either<Failure, MerchantWallet> _mapWallet(dynamic response) {
    return requireDataMap(response).map(MerchantWalletModel.fromJson);
  }
}
