import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/wallet_request.dart';
import '../entities/wallet_request_type.dart';
import '../repos/i_barber_wallet_requests_repo.dart';

class CreateWalletRequestUseCase {
  final IBarberWalletRequestsRepo _repo;

  CreateWalletRequestUseCase(this._repo);

  Future<Either<Failure, WalletRequest>> call({
    required WalletRequestType type,
    required int amount,
    int? transferAccountId,
    String? withdrawAccountNumber,
    String? note,
    String? filePath,
  }) => _repo.createWalletRequest(
    type: type,
    amount: amount,
    transferAccountId: transferAccountId,
    withdrawAccountNumber: withdrawAccountNumber,
    note: note,
    filePath: filePath,
  );
}
