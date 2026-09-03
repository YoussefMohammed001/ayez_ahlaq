import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../domain/entities/storefront_product.dart';
import '../../domain/repos/i_barber_storefront_products_repo.dart';
import '../apis/barber_storefront_products_api.dart';
import '../models/storefront_product_model.dart';
import '../requests/storefront_product_form_request.dart';

class BarberStorefrontProductsRepo implements IBarberStorefrontProductsRepo {
  final BarberStorefrontProductsApi _api;

  BarberStorefrontProductsRepo(this._api);

  @override
  Future<Either<Failure, List<StorefrontProduct>>> getProducts() async {
    final result = await _api.getProducts();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, StorefrontProduct>> createProduct(
    StorefrontProductFormRequest request,
  ) async {
    final result = await _api.createProduct(request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, StorefrontProduct>> updateProduct(
    int id,
    StorefrontProductFormRequest request,
  ) async {
    final result = await _api.updateProduct(id, request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    final result = await _api.deleteProduct(id);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, StorefrontProduct>> setStock(
    int id,
    int quantity,
  ) async {
    final result = await _api.setStock(id, quantity);
    return result.map(_mapOne);
  }

  List<StorefrontProduct> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<StorefrontProduct>(
          (e) => StorefrontProductModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  StorefrontProduct _mapOne(dynamic response) {
    return StorefrontProductModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
