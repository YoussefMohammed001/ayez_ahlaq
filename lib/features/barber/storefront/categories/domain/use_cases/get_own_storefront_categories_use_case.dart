import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_category.dart';
import '../repos/i_barber_storefront_categories_repo.dart';

class GetOwnStorefrontCategoriesUseCase {
  final IBarberStorefrontCategoriesRepo _repo;

  GetOwnStorefrontCategoriesUseCase(this._repo);

  Future<Either<Failure, List<StorefrontCategory>>> call() =>
      _repo.getOwnCategories();
}
