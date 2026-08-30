import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_category.dart';
import '../repos/i_merchant_categories_repo.dart';

class GetAssignableCategoriesUseCase {
  final IMerchantCategoriesRepo _repo;

  GetAssignableCategoriesUseCase(this._repo);

  Future<Either<Failure, List<MerchantCategory>>> call() =>
      _repo.getAssignableCategories();
}
