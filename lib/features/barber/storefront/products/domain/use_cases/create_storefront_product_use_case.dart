import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../data/requests/storefront_product_form_request.dart';
import '../entities/storefront_product.dart';
import '../repos/i_barber_storefront_products_repo.dart';

class CreateStorefrontProductUseCase {
  final IBarberStorefrontProductsRepo _repo;

  CreateStorefrontProductUseCase(this._repo);

  Future<Either<Failure, StorefrontProduct>> call(
    StorefrontProductFormRequest request,
  ) => _repo.createProduct(request);
}
