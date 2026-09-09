import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_wallet.dart';
import '../repos/i_customer_wallet_repo.dart';

class GetCustomerWalletUseCase {
  final ICustomerWalletRepo _repo;

  GetCustomerWalletUseCase(this._repo);

  Future<Either<Failure, CustomerWallet>> call() => _repo.getWallet();
}
