import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_category.dart';
import '../repos/i_barber_store_feed_repo.dart';

class GetStoreCategoriesUseCase {
  final IBarberStoreFeedRepo _repo;

  GetStoreCategoriesUseCase(this._repo);

  Future<Either<Failure, List<StoreCategory>>> call() => _repo.getCategories();
}
