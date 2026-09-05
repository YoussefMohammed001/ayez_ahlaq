import 'package:equatable/equatable.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/fulfillment_type.dart';
import '../../domain/entities/store_merchant.dart';
import '../../domain/entities/store_product.dart';

enum BarberStoreCartStatus { initial, loading, success, failure }

class BarberStoreCartState extends Equatable {
  final BarberStoreCartStatus status;
  final StoreMerchant? merchant;
  final List<StoreProduct> products;
  final Cart cart;
  final FulfillmentType? fulfillmentType;
  final String note;
  final bool isUpdatingCart;
  final bool isSubmitting;
  final String? errorMessage;

  const BarberStoreCartState({
    this.status = BarberStoreCartStatus.initial,
    this.merchant,
    this.products = const [],
    this.cart = Cart.empty,
    this.fulfillmentType,
    this.note = '',
    this.isUpdatingCart = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  int quantityFor(int productId) {
    final match = cart.lines.where((line) => line.productId == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  BarberStoreCartState copyWith({
    BarberStoreCartStatus? status,
    StoreMerchant? merchant,
    List<StoreProduct>? products,
    Cart? cart,
    FulfillmentType? fulfillmentType,
    bool clearFulfillmentType = false,
    String? note,
    bool? isUpdatingCart,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return BarberStoreCartState(
      status: status ?? this.status,
      merchant: merchant ?? this.merchant,
      products: products ?? this.products,
      cart: cart ?? this.cart,
      fulfillmentType: clearFulfillmentType
          ? null
          : (fulfillmentType ?? this.fulfillmentType),
      note: note ?? this.note,
      isUpdatingCart: isUpdatingCart ?? this.isUpdatingCart,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    merchant,
    products,
    cart,
    fulfillmentType,
    note,
    isUpdatingCart,
    isSubmitting,
    errorMessage,
  ];
}
