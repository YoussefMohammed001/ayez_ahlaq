import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_category.dart';
import '../repos/i_merchant_categories_repo.dart';

class GetOwnCategoriesUseCase {
  final IMerchantCategoriesRepo _repo;

  GetOwnCategoriesUseCase(this._repo);

  Future<Either<Failure, List<MerchantCategory>>> call() =>
      _repo.getOwnCategories();
}
