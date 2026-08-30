import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/category_form_request.dart';
import '../entities/merchant_category.dart';
import '../repos/i_merchant_categories_repo.dart';

class CreateCategoryUseCase {
  final IMerchantCategoriesRepo _repo;

  CreateCategoryUseCase(this._repo);

  Future<Either<Failure, MerchantCategory>> call(
    CategoryFormRequest request,
  ) => _repo.createCategory(request);
}
