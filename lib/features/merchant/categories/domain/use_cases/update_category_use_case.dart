import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/category_form_request.dart';
import '../entities/merchant_category.dart';
import '../repos/i_merchant_categories_repo.dart';

class UpdateCategoryUseCase {
  final IMerchantCategoriesRepo _repo;

  UpdateCategoryUseCase(this._repo);

  Future<Either<Failure, MerchantCategory>> call(
    int id,
    CategoryFormRequest request,
  ) => _repo.updateCategory(id, request);
}
