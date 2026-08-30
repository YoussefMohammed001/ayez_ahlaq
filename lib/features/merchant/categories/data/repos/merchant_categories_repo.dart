import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/merchant_category.dart';
import '../../domain/repos/i_merchant_categories_repo.dart';
import '../apis/merchant_categories_api.dart';
import '../models/merchant_category_model.dart';
import '../requests/category_form_request.dart';

class MerchantCategoriesRepo implements IMerchantCategoriesRepo {
  final MerchantCategoriesApi _api;

  MerchantCategoriesRepo(this._api);

  @override
  Future<Either<Failure, List<MerchantCategory>>>
  getAssignableCategories() async {
    final result = await _api.getAssignableCategories();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, List<MerchantCategory>>> getOwnCategories() async {
    final result = await _api.getOwnCategories();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, MerchantCategory>> createCategory(
    CategoryFormRequest request,
  ) async {
    final result = await _api.createCategory(request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantCategory>> updateCategory(
    int id,
    CategoryFormRequest request,
  ) async {
    final result = await _api.updateCategory(id, request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(int id) async {
    final result = await _api.deleteCategory(id);
    return result.map((_) => unit);
  }

  List<MerchantCategory> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<MerchantCategory>(
          (e) => MerchantCategoryModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  MerchantCategory _mapOne(dynamic response) {
    return MerchantCategoryModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
