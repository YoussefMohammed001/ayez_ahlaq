import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../repos/i_barber_storefront_categories_repo.dart';

class DeleteStorefrontCategoryUseCase {
  final IBarberStorefrontCategoriesRepo _repo;

  DeleteStorefrontCategoryUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteCategory(id);
}
