import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/withdraw_method.dart';
import '../repos/i_barber_wallet_requests_repo.dart';

class GetWithdrawMethodsUseCase {
  final IBarberWalletRequestsRepo _repo;

  GetWithdrawMethodsUseCase(this._repo);

  Future<Either<Failure, List<WithdrawMethod>>> call() => _repo.getWithdrawMethods();
}
