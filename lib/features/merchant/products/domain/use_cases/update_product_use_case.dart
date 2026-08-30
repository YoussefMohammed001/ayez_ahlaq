import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/product_form_request.dart';
import '../entities/merchant_product.dart';
import '../repos/i_merchant_products_repo.dart';

class UpdateProductUseCase {
  final IMerchantProductsRepo _repo;

  UpdateProductUseCase(this._repo);

  Future<Either<Failure, MerchantProduct>> call(
    int id,
    ProductFormRequest request,
  ) => _repo.updateProduct(id, request);
}
