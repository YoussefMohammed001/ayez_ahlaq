import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop_storefront.dart';
import '../repos/i_customer_store_repo.dart';

class GetStorefrontUseCase {
  final ICustomerStoreRepo _repo;

  GetStorefrontUseCase(this._repo);

  Future<Either<Failure, ShopStorefront>> call(int shopId) => _repo.getStorefront(shopId);
}
