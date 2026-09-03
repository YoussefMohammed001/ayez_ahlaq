import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../data/requests/storefront_product_form_request.dart';
import '../entities/storefront_product.dart';

abstract class IBarberStorefrontProductsRepo {
  Future<Either<Failure, List<StorefrontProduct>>> getProducts();

  Future<Either<Failure, StorefrontProduct>> createProduct(
    StorefrontProductFormRequest request,
  );

  Future<Either<Failure, StorefrontProduct>> updateProduct(
    int id,
    StorefrontProductFormRequest request,
  );

  Future<Either<Failure, Unit>> deleteProduct(int id);

  Future<Either<Failure, StorefrontProduct>> setStock(int id, int quantity);
}
