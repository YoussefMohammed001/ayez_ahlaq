import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/store_category.dart';
import '../../domain/entities/store_feed_page.dart';
import '../../domain/entities/store_feed_sort.dart';
import '../../domain/repos/i_barber_store_feed_repo.dart';
import '../apis/barber_store_feed_api.dart';
import '../models/store_category_model.dart';
import '../models/store_feed_page_model.dart';

class BarberStoreFeedRepo implements IBarberStoreFeedRepo {
  final BarberStoreFeedApi _api;

  BarberStoreFeedRepo(this._api);

  @override
  Future<Either<Failure, StoreFeedPage>> getProducts({
    String? search,
    int? categoryId,
    int? merchantId,
    required StoreFeedSort sort,
    String? cursor,
    int limit = 20,
  }) async {
    final result = await _api.getProducts(
      search: search,
      categoryId: categoryId,
      merchantId: merchantId,
      sort: sort.toApi(),
      cursor: cursor,
      limit: limit,
    );
    return result.flatMap(_mapPage);
  }

  @override
  Future<Either<Failure, List<StoreCategory>>> getCategories() async {
    final result = await _api.getCategories();
    return result.map(_mapCategories);
  }

  Either<Failure, StoreFeedPage> _mapPage(dynamic response) {
    return requireDataMap(response).map(StoreFeedPageModel.fromJson);
  }

  List<StoreCategory> _mapCategories(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => StoreCategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
