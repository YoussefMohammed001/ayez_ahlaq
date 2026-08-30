import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_products_repo.dart';

class DeactivateProductUseCase {
  final IMerchantProductsRepo _repo;

  DeactivateProductUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deactivateProduct(id);
}
