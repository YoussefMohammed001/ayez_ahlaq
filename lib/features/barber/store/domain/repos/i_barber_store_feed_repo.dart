import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_category.dart';
import '../entities/store_feed_page.dart';
import '../entities/store_feed_sort.dart';

abstract class IBarberStoreFeedRepo {
  Future<Either<Failure, StoreFeedPage>> getProducts({
    String? search,
    int? categoryId,
    int? merchantId,
    required StoreFeedSort sort,
    String? cursor,
    int limit = 20,
  });

  Future<Either<Failure, List<StoreCategory>>> getCategories();
}
