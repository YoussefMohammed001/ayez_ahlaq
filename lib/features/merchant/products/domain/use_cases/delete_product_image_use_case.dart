import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_products_repo.dart';

class DeleteProductImageUseCase {
  final IMerchantProductsRepo _repo;

  DeleteProductImageUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int productId, int imageId) =>
      _repo.deleteImage(productId, imageId);
}
