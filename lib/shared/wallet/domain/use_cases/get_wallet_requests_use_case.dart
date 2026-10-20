import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wallet_request_page.dart';
import '../repos/i_wallet_requests_repo.dart';

class GetWalletRequestsUseCase {
  final IWalletRequestsRepo _repo;

  GetWalletRequestsUseCase(this._repo);

  Future<Either<Failure, WalletRequestPage>> call({
    required int page,
    required int size,
  }) => _repo.getWalletRequests(page: page, size: size);
}
