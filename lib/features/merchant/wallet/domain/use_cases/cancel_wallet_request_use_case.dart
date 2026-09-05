import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/wallet_request.dart';
import '../repos/i_merchant_wallet_requests_repo.dart';

class CancelWalletRequestUseCase {
  final IMerchantWalletRequestsRepo _repo;

  CancelWalletRequestUseCase(this._repo);

  Future<Either<Failure, WalletRequest>> call(int id) =>
      _repo.cancelWalletRequest(id);
}
