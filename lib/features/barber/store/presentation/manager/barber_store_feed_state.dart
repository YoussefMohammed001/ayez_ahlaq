import 'package:equatable/equatable.dart';
import '../../domain/entities/store_category.dart';
import '../../domain/entities/store_feed_product.dart';
import '../../domain/entities/store_feed_sort.dart';

enum BarberStoreFeedStatus { initial, loading, loadingMore, success, failure }

class BarberStoreFeedState extends Equatable {
  final BarberStoreFeedStatus status;
  final List<StoreFeedProduct> products;
  final List<StoreCategory> categories;
  final String? nextCursor;
  final String search;
  final int? categoryId;
  final StoreFeedSort sort;
  final String? errorMessage;

  const BarberStoreFeedState({
    this.status = BarberStoreFeedStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.nextCursor,
    this.search = '',
    this.categoryId,
    this.sort = StoreFeedSort.relevant,
    this.errorMessage,
  });

  bool get hasMore => nextCursor != null;

  BarberStoreFeedState copyWith({
    BarberStoreFeedStatus? status,
    List<StoreFeedProduct>? products,
    List<StoreCategory>? categories,
    String? nextCursor,
    bool clearNextCursor = false,
    String? search,
    int? categoryId,
    bool clearCategoryId = false,
    StoreFeedSort? sort,
    String? errorMessage,
  }) {
    return BarberStoreFeedState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      nextCursor: clearNextCursor ? null : (nextCursor ?? this.nextCursor),
      search: search ?? this.search,
      categoryId: clearCategoryId ? null : (categoryId ?? this.categoryId),
      sort: sort ?? this.sort,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    categories,
    nextCursor,
    search,
    categoryId,
    sort,
    errorMessage,
  ];
}
