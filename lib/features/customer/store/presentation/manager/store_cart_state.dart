import 'package:equatable/equatable.dart';
import '../../domain/entities/shop_storefront.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_quote.dart';

enum StoreCartStatus {
  initial,
  loading,
  loaded,
  quoting,
  placingOrder,
  orderPlaced,
  failure,
}

class StoreCartState extends Equatable {
  final StoreCartStatus status;
  final int? shopId;
  final ShopStorefront? storefront;
  final Map<int, int> items;
  final StoreFulfillmentType fulfillmentType;
  final String paymentMethod;
  final StoreQuote? quote;
  final StoreOrder? placedOrder;
  final String? errorMessage;

  const StoreCartState({
    this.status = StoreCartStatus.initial,
    this.shopId,
    this.storefront,
    this.items = const {},
    this.fulfillmentType = StoreFulfillmentType.delivery,
    this.paymentMethod = 'CASH',
    this.quote,
    this.placedOrder,
    this.errorMessage,
  });

  int get itemCount => items.values.fold(0, (sum, qty) => sum + qty);

  bool get isEmpty => items.isEmpty;

  bool hasItemsFromOtherShop(int otherShopId) =>
      items.isNotEmpty && shopId != null && shopId != otherShopId;

  int quantityFor(int productId) => items[productId] ?? 0;

  int get subtotal {
    final priceById = <int, int>{
      for (final p in storefront?.products ?? const []) p.id: p.price,
    };
    return items.entries.fold<int>(
      0,
      (sum, entry) => sum + (priceById[entry.key] ?? 0) * entry.value,
    );
  }

  StoreCartState copyWith({
    StoreCartStatus? status,
    int? shopId,
    ShopStorefront? storefront,
    Map<int, int>? items,
    StoreFulfillmentType? fulfillmentType,
    String? paymentMethod,
    StoreQuote? quote,
    StoreOrder? placedOrder,
    String? errorMessage,
    bool clearQuote = false,
  }) {
    return StoreCartState(
      status: status ?? this.status,
      shopId: shopId ?? this.shopId,
      storefront: storefront ?? this.storefront,
      items: items ?? this.items,
      fulfillmentType: fulfillmentType ?? this.fulfillmentType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      quote: clearQuote ? null : (quote ?? this.quote),
      placedOrder: placedOrder ?? this.placedOrder,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    shopId,
    storefront,
    items,
    fulfillmentType,
    paymentMethod,
    quote,
    placedOrder,
    errorMessage,
  ];
}
