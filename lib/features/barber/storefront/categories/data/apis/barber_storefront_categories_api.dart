import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/constants/endpoints.dart';
import '../../../../../../core/network/dio/network_service.dart';
import '../requests/storefront_category_form_request.dart';

class BarberStorefrontCategoriesApi {
  final NetworkService _networkService;

  BarberStorefrontCategoriesApi(this._networkService);

  Future<Either<Failure, dynamic>> getAssignableCategories() {
    return _networkService.getData(
      endPoint: EndPoints.barberStorefrontCategory,
    );
  }

  Future<Either<Failure, dynamic>> getOwnCategories() {
    return _networkService.getData(
      endPoint: EndPoints.barberStorefrontOwnCategory,
    );
  }

  Future<Either<Failure, dynamic>> createCategory(
    StorefrontCategoryFormRequest request,
  ) {
    return _networkService.uploadFile(
      endPoint: EndPoints.barberStorefrontCategory,
      formData: FormData.fromMap(request.toFormMap()),
    );
  }

  Future<Either<Failure, dynamic>> deleteCategory(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.barberStorefrontCategoryById(id),
    );
  }
}
