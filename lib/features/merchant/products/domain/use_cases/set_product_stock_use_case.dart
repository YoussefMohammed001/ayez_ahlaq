import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_product.dart';
import '../repos/i_merchant_products_repo.dart';

class SetProductStockUseCase {
  final IMerchantProductsRepo _repo;

  SetProductStockUseCase(this._repo);

  Future<Either<Failure, MerchantProduct>> call(int id, int quantity) =>
      _repo.setStock(id, quantity);
}
