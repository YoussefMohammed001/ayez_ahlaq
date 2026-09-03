import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_category.dart';
import '../repos/i_barber_storefront_categories_repo.dart';

class GetAssignableStorefrontCategoriesUseCase {
  final IBarberStorefrontCategoriesRepo _repo;

  GetAssignableStorefrontCategoriesUseCase(this._repo);

  Future<Either<Failure, List<StorefrontCategory>>> call() =>
      _repo.getAssignableCategories();
}
