import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/category_form_request.dart';
import '../entities/merchant_category.dart';

abstract class IMerchantCategoriesRepo {
  Future<Either<Failure, List<MerchantCategory>>> getAssignableCategories();

  Future<Either<Failure, List<MerchantCategory>>> getOwnCategories();

  Future<Either<Failure, MerchantCategory>> createCategory(
    CategoryFormRequest request,
  );

  Future<Either<Failure, MerchantCategory>> updateCategory(
    int id,
    CategoryFormRequest request,
  );

  Future<Either<Failure, Unit>> deleteCategory(int id);
}
