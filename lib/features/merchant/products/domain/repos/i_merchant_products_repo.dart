import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/product_form_request.dart';
import '../entities/merchant_product.dart';

abstract class IMerchantProductsRepo {
  Future<Either<Failure, List<MerchantProduct>>> getProducts();

  Future<Either<Failure, MerchantProduct>> getProduct(int id);

  Future<Either<Failure, MerchantProduct>> createProduct(
    ProductFormRequest request,
  );

  Future<Either<Failure, MerchantProduct>> updateProduct(
    int id,
    ProductFormRequest request,
  );

  Future<Either<Failure, Unit>> deleteProduct(int id);

  Future<Either<Failure, MerchantProduct>> setStock(int id, int quantity);

  Future<Either<Failure, Unit>> deleteImage(int productId, int imageId);
}
