import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/transfer_account.dart';
import '../repos/i_customer_wallet_requests_repo.dart';

class GetTransferAccountsUseCase {
  final ICustomerWalletRequestsRepo _repo;

  GetTransferAccountsUseCase(this._repo);

  Future<Either<Failure, List<TransferAccount>>> call() =>
      _repo.getTransferAccounts();
}
