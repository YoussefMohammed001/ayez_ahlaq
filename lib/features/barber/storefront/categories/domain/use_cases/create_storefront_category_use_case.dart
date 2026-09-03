import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../data/requests/storefront_category_form_request.dart';
import '../entities/storefront_category.dart';
import '../repos/i_barber_storefront_categories_repo.dart';

class CreateStorefrontCategoryUseCase {
  final IBarberStorefrontCategoriesRepo _repo;

  CreateStorefrontCategoryUseCase(this._repo);

  Future<Either<Failure, StorefrontCategory>> call(
    StorefrontCategoryFormRequest request,
  ) => _repo.createCategory(request);
}
