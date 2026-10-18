import 'package:equatable/equatable.dart';
import '../../domain/entities/store_feed_product.dart';

enum CustomerStoreFeedStatus { initial, loading, success, failure }

class CustomerStoreFeedState extends Equatable {
  final CustomerStoreFeedStatus status;
  final List<StoreFeedProduct> items;
  final String search;
  final String? categoryName;
  final String? errorMessage;

  const CustomerStoreFeedState({
    this.status = CustomerStoreFeedStatus.initial,
    this.items = const [],
    this.search = '',
    this.categoryName,
    this.errorMessage,
  });

  List<String> get categories => items
      .map((item) => item.product.categoryName)
      .whereType<String>()
      .where((name) => name.isNotEmpty)
      .toSet()
      .toList();

  List<StoreFeedProduct> get filteredItems => items.where((item) {
    final matchesCategory =
        categoryName == null || item.product.categoryName == categoryName;
    final matchesSearch = search.isEmpty ||
        item.product.name.toLowerCase().contains(search.toLowerCase()) ||
        (item.product.brand ?? '').toLowerCase().contains(search.toLowerCase());
    return matchesCategory && matchesSearch;
  }).toList();

  CustomerStoreFeedState copyWith({
    CustomerStoreFeedStatus? status,
    List<StoreFeedProduct>? items,
    String? search,
    String? categoryName,
    bool clearCategoryName = false,
    String? errorMessage,
  }) {
    return CustomerStoreFeedState(
      status: status ?? this.status,
      items: items ?? this.items,
      search: search ?? this.search,
      categoryName: clearCategoryName ? null : (categoryName ?? this.categoryName),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, search, categoryName, errorMessage];
}
