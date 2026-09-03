import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_merchant.dart';
import '../repos/i_barber_store_repo.dart';

class GetStoreMerchantsUseCase {
  final IBarberStoreRepo _repo;

  GetStoreMerchantsUseCase(this._repo);

  Future<Either<Failure, List<StoreMerchant>>> call() => _repo.getMerchants();
}
