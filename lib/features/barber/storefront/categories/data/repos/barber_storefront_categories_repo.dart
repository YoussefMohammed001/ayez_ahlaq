import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../domain/entities/storefront_category.dart';
import '../../domain/repos/i_barber_storefront_categories_repo.dart';
import '../apis/barber_storefront_categories_api.dart';
import '../models/storefront_category_model.dart';
import '../requests/storefront_category_form_request.dart';

class BarberStorefrontCategoriesRepo
    implements IBarberStorefrontCategoriesRepo {
  final BarberStorefrontCategoriesApi _api;

  BarberStorefrontCategoriesRepo(this._api);

  @override
  Future<Either<Failure, List<StorefrontCategory>>>
  getAssignableCategories() async {
    final result = await _api.getAssignableCategories();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, List<StorefrontCategory>>> getOwnCategories() async {
    final result = await _api.getOwnCategories();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, StorefrontCategory>> createCategory(
    StorefrontCategoryFormRequest request,
  ) async {
    final result = await _api.createCategory(request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(int id) async {
    final result = await _api.deleteCategory(id);
    return result.map((_) => unit);
  }

  List<StorefrontCategory> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<StorefrontCategory>(
          (e) => StorefrontCategoryModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  StorefrontCategory _mapOne(dynamic response) {
    return StorefrontCategoryModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
