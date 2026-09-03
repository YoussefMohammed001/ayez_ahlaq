import 'package:equatable/equatable.dart';
import '../../domain/entities/storefront_product.dart';

enum StorefrontProductsStatus { initial, loading, success, failure }

class BarberStorefrontProductsState extends Equatable {
  final StorefrontProductsStatus status;
  final List<StorefrontProduct> products;
  final String? errorMessage;
  final bool isSubmitting;
  final int? categoryFilter;

  const BarberStorefrontProductsState({
    this.status = StorefrontProductsStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.isSubmitting = false,
    this.categoryFilter,
  });

  List<StorefrontProduct> get visibleProducts => categoryFilter == null
      ? products
      : products.where((p) => p.categoryId == categoryFilter).toList();

  List<int> get usedCategoryIds =>
      products.map((p) => p.categoryId).whereType<int>().toSet().toList();

  BarberStorefrontProductsState copyWith({
    StorefrontProductsStatus? status,
    List<StorefrontProduct>? products,
    String? errorMessage,
    bool? isSubmitting,
    int? categoryFilter,
    bool clearCategoryFilter = false,
  }) {
    return BarberStorefrontProductsState(
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
