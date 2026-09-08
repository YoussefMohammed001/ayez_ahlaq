import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/broadcast_page.dart';
import '../repos/i_merchant_broadcast_repo.dart';

class GetMerchantBroadcastsUseCase {
  final IMerchantBroadcastRepo _repo;

  GetMerchantBroadcastsUseCase(this._repo);

  Future<Either<Failure, BroadcastPage>> call({
    required int page,
    required int size,
  }) => _repo.list(page: page, size: size);
}
