import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/product_form_request.dart';
import '../entities/merchant_product.dart';
import '../repos/i_merchant_products_repo.dart';

class CreateProductUseCase {
  final IMerchantProductsRepo _repo;

  CreateProductUseCase(this._repo);

  Future<Either<Failure, MerchantProduct>> call(ProductFormRequest request) =>
      _repo.createProduct(request);
}
