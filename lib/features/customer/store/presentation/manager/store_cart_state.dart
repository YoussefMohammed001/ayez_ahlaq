import 'package:equatable/equatable.dart';
import '../../domain/entities/shop_storefront.dart';
import '../../domain/entities/store_cart.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/entities/store_order.dart';

enum StoreCartStatus { initial, loading, success, failure }

class StoreCartState extends Equatable {
  final StoreCartStatus status;
  final ShopStorefront? storefront;
  final StoreCart cart;
  final StoreFulfillmentType? fulfillmentType;
  final String paymentMethod;
  final String deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;
  final String note;
  final bool isUpdatingCart;
  final bool isSubmitting;
  final StoreOrder? placedOrder;
  final String? errorMessage;

  const StoreCartState({
    this.status = StoreCartStatus.initial,
    this.storefront,
    this.cart = StoreCart.empty,
    this.fulfillmentType,
    this.paymentMethod = 'CASH',
    this.deliveryAddress = '',
    this.deliveryLat,
    this.deliveryLng,
    this.note = '',
    this.isUpdatingCart = false,
    this.isSubmitting = false,
    this.placedOrder,
    this.errorMessage,
  });

  bool get isEmpty => cart.isEmpty;

  bool get isDelivery => fulfillmentType == StoreFulfillmentType.delivery;

  String? get checkoutDeliveryAddress =>
      isDelivery && deliveryAddress.isNotEmpty ? deliveryAddress : null;

  double? get checkoutDeliveryLat => isDelivery ? deliveryLat : null;

  double? get checkoutDeliveryLng => isDelivery ? deliveryLng : null;

  String? get checkoutNote => note.isEmpty ? null : note;

  int quantityFor(int productId) {
    final match = cart.lines.where((line) => line.productId == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  StoreCartState copyWith({
    StoreCartStatus? status,
    ShopStorefront? storefront,
    StoreCart? cart,
    StoreFulfillmentType? fulfillmentType,
    bool clearFulfillmentType = false,
    String? paymentMethod,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    String? note,
    bool? isUpdatingCart,
    bool? isSubmitting,
    StoreOrder? placedOrder,
    String? errorMessage,
  }) {
    return StoreCartState(
      status: status ?? this.status,
      storefront: storefront ?? this.storefront,
      cart: cart ?? this.cart,
      fulfillmentType: clearFulfillmentType
          ? null
          : (fulfillmentType ?? this.fulfillmentType),
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLat: deliveryLat ?? this.deliveryLat,
      deliveryLng: deliveryLng ?? this.deliveryLng,
      note: note ?? this.note,
      isUpdatingCart: isUpdatingCart ?? this.isUpdatingCart,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      placedOrder: placedOrder ?? this.placedOrder,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    storefront,
    cart,
    fulfillmentType,
    paymentMethod,
    deliveryAddress,
    deliveryLat,
    deliveryLng,
    note,
    isUpdatingCart,
    isSubmitting,
    placedOrder,
    errorMessage,
  ];
}
