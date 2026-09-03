import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../data/requests/storefront_product_form_request.dart';
import '../entities/storefront_product.dart';
import '../repos/i_barber_storefront_products_repo.dart';

class UpdateStorefrontProductUseCase {
  final IBarberStorefrontProductsRepo _repo;

  UpdateStorefrontProductUseCase(this._repo);

  Future<Either<Failure, StorefrontProduct>> call(
    int id,
    StorefrontProductFormRequest request,
  ) => _repo.updateProduct(id, request);
}
