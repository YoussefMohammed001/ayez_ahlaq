import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/wallet_request.dart';
import '../entities/wallet_request_type.dart';
import '../repos/i_merchant_wallet_requests_repo.dart';

class CreateWalletRequestUseCase {
  final IMerchantWalletRequestsRepo _repo;

  CreateWalletRequestUseCase(this._repo);

  Future<Either<Failure, WalletRequest>> call({
    required WalletRequestType type,
    required int amount,
    String? note,
    String? filePath,
  }) => _repo.createWalletRequest(
    type: type,
    amount: amount,
    note: note,
    filePath: filePath,
  );
}
