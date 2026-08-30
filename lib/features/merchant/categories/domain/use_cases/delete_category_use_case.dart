import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_categories_repo.dart';

class DeleteCategoryUseCase {
  final IMerchantCategoriesRepo _repo;

  DeleteCategoryUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteCategory(id);
}
