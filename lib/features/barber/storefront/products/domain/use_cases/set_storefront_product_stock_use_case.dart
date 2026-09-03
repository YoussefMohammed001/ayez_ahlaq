import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_product.dart';
import '../repos/i_barber_storefront_products_repo.dart';

class SetStorefrontProductStockUseCase {
  final IBarberStorefrontProductsRepo _repo;

  SetStorefrontProductStockUseCase(this._repo);

  Future<Either<Failure, StorefrontProduct>> call(int id, int quantity) =>
      _repo.setStock(id, quantity);
}
