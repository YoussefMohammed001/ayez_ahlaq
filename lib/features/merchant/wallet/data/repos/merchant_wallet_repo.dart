import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
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
    return result.map(_mapWallet);
  }

  MerchantWallet _mapWallet(dynamic response) {
    return MerchantWalletModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
