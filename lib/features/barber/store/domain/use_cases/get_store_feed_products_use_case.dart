import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_feed_page.dart';
import '../entities/store_feed_sort.dart';
import '../repos/i_barber_store_feed_repo.dart';

class GetStoreFeedProductsUseCase {
  final IBarberStoreFeedRepo _repo;

  GetStoreFeedProductsUseCase(this._repo);

  Future<Either<Failure, StoreFeedPage>> call({
    String? search,
    int? categoryId,
    int? merchantId,
    StoreFeedSort sort = StoreFeedSort.relevant,
    String? cursor,
    int limit = 20,
  }) {
    return _repo.getProducts(
      search: search,
      categoryId: categoryId,
      merchantId: merchantId,
      sort: sort,
      cursor: cursor,
      limit: limit,
    );
  }
}
