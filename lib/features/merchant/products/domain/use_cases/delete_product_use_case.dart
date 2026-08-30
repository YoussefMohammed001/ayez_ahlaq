import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_products_repo.dart';

class DeleteProductUseCase {
  final IMerchantProductsRepo _repo;

  DeleteProductUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteProduct(id);
}
