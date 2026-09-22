import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/withdraw_method.dart';
import '../repos/i_customer_wallet_requests_repo.dart';

class GetWithdrawMethodsUseCase {
  final ICustomerWalletRequestsRepo _repo;

  GetWithdrawMethodsUseCase(this._repo);

  Future<Either<Failure, List<WithdrawMethod>>> call() => _repo.getWithdrawMethods();
}
