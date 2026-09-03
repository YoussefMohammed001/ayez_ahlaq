import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_product.dart';
import '../repos/i_barber_store_repo.dart';

class GetMerchantProductsUseCase {
  final IBarberStoreRepo _repo;

  GetMerchantProductsUseCase(this._repo);

  Future<Either<Failure, List<StoreProduct>>> call(int merchantId) =>
      _repo.getMerchantProducts(merchantId);
}
