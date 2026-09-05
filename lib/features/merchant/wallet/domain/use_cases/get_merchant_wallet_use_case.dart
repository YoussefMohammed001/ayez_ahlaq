import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_wallet.dart';
import '../repos/i_merchant_wallet_repo.dart';

class GetMerchantWalletUseCase {
  final IMerchantWalletRepo _repo;

  GetMerchantWalletUseCase(this._repo);

  Future<Either<Failure, MerchantWallet>> call() => _repo.getWallet();
}
