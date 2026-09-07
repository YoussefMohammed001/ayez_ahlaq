import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/use_cases/get_storefront_use_case.dart';
import '../../domain/use_cases/place_store_order_use_case.dart';
import '../../domain/use_cases/quote_store_cart_use_case.dart';
import 'store_cart_state.dart';

class StoreCartCubit extends Cubit<StoreCartState> {
  final GetStorefrontUseCase _getStorefront;
  final QuoteStoreCartUseCase _quoteCart;
  final PlaceStoreOrderUseCase _placeOrder;

  StoreCartCubit(this._getStorefront, this._quoteCart, this._placeOrder)
    : super(const StoreCartState());

  Future<void> openShop(int shopId) async {
    emit(StoreCartState(status: StoreCartStatus.loading, shopId: shopId));

    final result = await _getStorefront(shopId);

    result.fold(
      (failure) => emit(
        state.copyWith(status: StoreCartStatus.failure, errorMessage: failure.message),
      ),
      (storefront) => emit(
        state.copyWith(
          status: StoreCartStatus.loaded,
          storefront: storefront,
          fulfillmentType: storefront.delivery.offered
              ? state.fulfillmentType
              : StoreFulfillmentType.pickupAtBranch,
        ),
      ),
    );
  }

  void setQuantity(int productId, int quantity) {
    final items = Map<int, int>.from(state.items);
    if (quantity <= 0) {
      items.remove(productId);
    } else {
      items[productId] = quantity;
    }
    emit(state.copyWith(items: items, clearQuote: true));
  }

  void setFulfillmentType(StoreFulfillmentType type) {
    if (type == StoreFulfillmentType.delivery &&
        state.storefront?.delivery.offered == false) {
      return;
    }
    emit(state.copyWith(fulfillmentType: type, clearQuote: true));
  }

  void setPaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: method));
  }

  Future<void> refreshQuote() async {
    final shopId = state.shopId;
    if (shopId == null || state.isEmpty) {
      emit(state.copyWith(clearQuote: true));
      return;
    }

    emit(state.copyWith(status: StoreCartStatus.quoting));

    final result = await _quoteCart(
      shopId: shopId,
      fulfillmentType: state.fulfillmentType,
      items: state.items,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: StoreCartStatus.failure, errorMessage: failure.message),
      ),
      (quote) => emit(state.copyWith(status: StoreCartStatus.loaded, quote: quote)),
    );
  }

  Future<void> placeOrder({String? note}) async {
    final shopId = state.shopId;
    if (shopId == null || state.isEmpty) return;

    emit(state.copyWith(status: StoreCartStatus.placingOrder));

    final result = await _placeOrder(
      shopId: shopId,
      fulfillmentType: state.fulfillmentType,
      paymentMethod: state.paymentMethod,
      note: note,
      items: state.items,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: StoreCartStatus.failure, errorMessage: failure.message),
      ),
      (order) => emit(
        state.copyWith(status: StoreCartStatus.orderPlaced, placedOrder: order),
      ),
    );
  }
}
