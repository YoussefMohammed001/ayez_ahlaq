import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/merchant_product.dart';
import '../../domain/repos/i_merchant_products_repo.dart';
import '../apis/merchant_products_api.dart';
import '../models/merchant_product_model.dart';
import '../requests/product_form_request.dart';

class MerchantProductsRepo implements IMerchantProductsRepo {
  final MerchantProductsApi _api;

  MerchantProductsRepo(this._api);

  @override
  Future<Either<Failure, List<MerchantProduct>>> getProducts() async {
    final result = await _api.getProducts();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, MerchantProduct>> getProduct(int id) async {
    final result = await _api.getProduct(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantProduct>> createProduct(
    ProductFormRequest request,
  ) async {
    final result = await _api.createProduct(request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantProduct>> updateProduct(
    int id,
    ProductFormRequest request,
  ) async {
    final result = await _api.updateProduct(id, request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deactivateProduct(int id) async {
    final result = await _api.deactivateProduct(id);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, MerchantProduct>> setStock(
    int id,
    int quantity,
  ) async {
    final result = await _api.setStock(id, quantity);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteImage(int productId, int imageId) async {
    final result = await _api.deleteImage(productId, imageId);
    return result.map((_) => unit);
  }

  List<MerchantProduct> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<MerchantProduct>((e) => MerchantProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  MerchantProduct _mapOne(dynamic response) {
    return MerchantProductModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
