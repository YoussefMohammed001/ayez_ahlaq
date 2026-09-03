import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/constants/endpoints.dart';
import '../../../../../../core/network/dio/network_service.dart';
import '../requests/storefront_product_form_request.dart';

class BarberStorefrontProductsApi {
  final NetworkService _networkService;

  BarberStorefrontProductsApi(this._networkService);

  Future<Either<Failure, dynamic>> getProducts() {
    return _networkService.getData(endPoint: EndPoints.barberStorefrontProduct);
  }

  Future<Either<Failure, dynamic>> createProduct(
    StorefrontProductFormRequest request,
  ) {
    return _networkService.uploadFile(
      endPoint: EndPoints.barberStorefrontProduct,
      formData: FormData.fromMap(request.toFormMap()),
    );
  }

  Future<Either<Failure, dynamic>> updateProduct(
    int id,
    StorefrontProductFormRequest request,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberStorefrontProductById(id),
      data: FormData.fromMap(request.toFormMap()),
    );
  }

  Future<Either<Failure, dynamic>> deleteProduct(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.barberStorefrontProductById(id),
    );
  }

  Future<Either<Failure, dynamic>> setStock(int id, int quantity) {
    return _networkService.putData(
      endPoint: EndPoints.barberStorefrontProductStock(id),
      data: {'quantity': quantity},
    );
  }
}
