import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wallet.dart';

abstract class IWalletRepo {
  Future<Either<Failure, Wallet>> getWallet();
}
