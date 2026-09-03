import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../data/requests/storefront_category_form_request.dart';
import '../entities/storefront_category.dart';

abstract class IBarberStorefrontCategoriesRepo {
  Future<Either<Failure, List<StorefrontCategory>>> getAssignableCategories();

  Future<Either<Failure, List<StorefrontCategory>>> getOwnCategories();

  Future<Either<Failure, StorefrontCategory>> createCategory(
    StorefrontCategoryFormRequest request,
  );

  Future<Either<Failure, Unit>> deleteCategory(int id);
}
