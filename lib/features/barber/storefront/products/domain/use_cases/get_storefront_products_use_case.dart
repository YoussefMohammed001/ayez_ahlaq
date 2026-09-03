import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_product.dart';
import '../repos/i_barber_storefront_products_repo.dart';

class GetStorefrontProductsUseCase {
  final IBarberStorefrontProductsRepo _repo;

  GetStorefrontProductsUseCase(this._repo);

  Future<Either<Failure, List<StorefrontProduct>>> call() =>
      _repo.getProducts();
}
