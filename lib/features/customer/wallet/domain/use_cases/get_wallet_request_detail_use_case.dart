import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/wallet_request.dart';
import '../repos/i_customer_wallet_requests_repo.dart';

class GetWalletRequestDetailUseCase {
  final ICustomerWalletRequestsRepo _repo;

  GetWalletRequestDetailUseCase(this._repo);

  Future<Either<Failure, WalletRequest>> call(int id) =>
      _repo.getWalletRequestDetail(id);
}
