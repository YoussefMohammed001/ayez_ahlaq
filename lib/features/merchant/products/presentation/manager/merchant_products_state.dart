import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_product.dart';

enum ProductsStatus { initial, loading, success, failure }

class MerchantProductsState extends Equatable {
  final ProductsStatus status;
  final List<MerchantProduct> products;
  final String? errorMessage;
  final bool isSubmitting;

  const MerchantProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  List<MerchantProduct> get activeProducts =>
      products.where((p) => p.active).toList();

  MerchantProductsState copyWith({
    ProductsStatus? status,
    List<MerchantProduct>? products,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MerchantProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, isSubmitting];
}
