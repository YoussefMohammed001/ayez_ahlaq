import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_product.dart';
import '../repos/i_merchant_products_repo.dart';

class GetProductsUseCase {
  final IMerchantProductsRepo _repo;

  GetProductsUseCase(this._repo);

  Future<Either<Failure, List<MerchantProduct>>> call() => _repo.getProducts();
}
