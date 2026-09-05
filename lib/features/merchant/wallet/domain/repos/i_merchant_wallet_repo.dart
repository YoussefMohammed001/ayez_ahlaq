import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_wallet.dart';

abstract class IMerchantWalletRepo {
  Future<Either<Failure, MerchantWallet>> getWallet();
}
