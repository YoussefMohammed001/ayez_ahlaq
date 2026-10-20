import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wallet.dart';
import '../repos/i_wallet_repo.dart';

class GetWalletUseCase {
  final IWalletRepo _repo;

  GetWalletUseCase(this._repo);

  Future<Either<Failure, Wallet>> call() => _repo.getWallet();
}
