import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_product.dart';

enum ProductsStatus { initial, loading, success, failure }

class MerchantProductsState extends Equatable {
  final ProductsStatus status;
  final List<MerchantProduct> products;
  final String? errorMessage;
  final bool isSubmitting;
  final int? categoryFilter;

  const MerchantProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.isSubmitting = false,
    this.categoryFilter,
  });

  List<MerchantProduct> get visibleProducts => categoryFilter == null
      ? products
      : products.where((p) => p.categoryId == categoryFilter).toList();

  List<int> get usedCategoryIds =>
      products.map((p) => p.categoryId).whereType<int>().toSet().toList();

  MerchantProductsState copyWith({
    ProductsStatus? status,
    List<MerchantProduct>? products,
    String? errorMessage,
    bool? isSubmitting,
    int? categoryFilter,
    bool clearCategoryFilter = false,
  }) {
    return MerchantProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      categoryFilter: clearCategoryFilter
          ? null
          : categoryFilter ?? this.categoryFilter,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    errorMessage,
    isSubmitting,
    categoryFilter,
  ];
}
