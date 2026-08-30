import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../requests/product_form_request.dart';

class MerchantProductsApi {
  final NetworkService _networkService;

  MerchantProductsApi(this._networkService);

  Future<Either<Failure, dynamic>> getProducts() {
    return _networkService.getData(endPoint: EndPoints.merchantProduct);
  }

  Future<Either<Failure, dynamic>> getProduct(int id) {
    return _networkService.getData(
      endPoint: EndPoints.merchantProductById(id),
    );
  }

  Future<Either<Failure, dynamic>> createProduct(ProductFormRequest request) {
    return _networkService.uploadFile(
      endPoint: EndPoints.merchantProduct,
      formData: FormData.fromMap(request.toFormMap()),
    );
  }

  Future<Either<Failure, dynamic>> updateProduct(
    int id,
    ProductFormRequest request,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.merchantProductById(id),
      data: FormData.fromMap(request.toFormMap()),
    );
  }

  Future<Either<Failure, dynamic>> deactivateProduct(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantProductById(id),
    );
  }

  Future<Either<Failure, dynamic>> setStock(int id, int quantity) {
    return _networkService.putData(
      endPoint: EndPoints.merchantProductStock(id),
      data: {'quantity': quantity},
    );
  }

  Future<Either<Failure, dynamic>> deleteImage(int id, int imageId) {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantProductImageById(id, imageId),
    );
  }
}
