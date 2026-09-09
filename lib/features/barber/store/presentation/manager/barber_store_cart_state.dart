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
  final String deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;
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
    this.deliveryAddress = '',
    this.deliveryLat,
    this.deliveryLng,
    this.isUpdatingCart = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  int quantityFor(int productId) {
    final match = cart.lines.where((line) => line.productId == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  bool get isDelivery => fulfillmentType == FulfillmentType.delivery;

  FulfillmentType? resolvedFulfillmentType(Cart nextCart) {
    if (!nextCart.deliveryOffered && fulfillmentType == FulfillmentType.delivery) {
      return FulfillmentType.pickupAtBranch;
    }
    return fulfillmentType;
  }

  String? get checkoutDeliveryAddress =>
      isDelivery && deliveryAddress.isNotEmpty ? deliveryAddress : null;

  double? get checkoutDeliveryLat => isDelivery ? deliveryLat : null;

  double? get checkoutDeliveryLng => isDelivery ? deliveryLng : null;

  BarberStoreCartState copyWith({
    BarberStoreCartStatus? status,
    StoreMerchant? merchant,
    List<StoreProduct>? products,
    Cart? cart,
    FulfillmentType? fulfillmentType,
    bool clearFulfillmentType = false,
    String? note,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
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
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLat: deliveryLat ?? this.deliveryLat,
      deliveryLng: deliveryLng ?? this.deliveryLng,
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
    deliveryAddress,
    deliveryLat,
    deliveryLng,
    isUpdatingCart,
    isSubmitting,
    errorMessage,
  ];
}
