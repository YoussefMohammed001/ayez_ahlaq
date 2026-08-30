import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../requests/category_form_request.dart';

class MerchantCategoriesApi {
  final NetworkService _networkService;

  MerchantCategoriesApi(this._networkService);

  Future<Either<Failure, dynamic>> getAssignableCategories() {
    return _networkService.getData(endPoint: EndPoints.merchantCategory);
  }

  Future<Either<Failure, dynamic>> getOwnCategories() {
    return _networkService.getData(endPoint: EndPoints.merchantOwnCategory);
  }

  Future<Either<Failure, dynamic>> createCategory(CategoryFormRequest request) {
    return _networkService.uploadFile(
      endPoint: EndPoints.merchantCategory,
      formData: FormData.fromMap(request.toFormMap()),
    );
  }

  Future<Either<Failure, dynamic>> updateCategory(
    int id,
    CategoryFormRequest request,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.merchantCategoryById(id),
      data: FormData.fromMap(request.toFormMap()),
    );
  }

  Future<Either<Failure, dynamic>> deleteCategory(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantCategoryById(id),
    );
  }
}
