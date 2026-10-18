import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../domain/entities/store_cart.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/use_cases/checkout_cart_use_case.dart';
import '../../domain/use_cases/get_cart_use_case.dart';
import '../../domain/use_cases/get_storefront_use_case.dart';
import '../../domain/use_cases/put_cart_use_case.dart';
import 'store_cart_state.dart';

class StoreCartCubit extends Cubit<StoreCartState> {
  final GetStorefrontUseCase _getStorefront;
  final GetCartUseCase _getCart;
  final PutCartUseCase _putCart;
  final CheckoutCartUseCase _checkout;

  StoreCartCubit(
    this._getStorefront,
    this._getCart,
    this._putCart,
    this._checkout,
  ) : super(const StoreCartState());

  Future<void> loadCart() async {
    if (await UserHelpers.isGuest()) return;

    final result = await _getCart();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (cart) => emit(state.copyWith(cart: cart, fulfillmentType: _resolveFulfillmentType(cart))),
    );
  }

  StoreFulfillmentType? _resolveFulfillmentType(StoreCart cart) {
    if (!cart.deliveryOffered && state.fulfillmentType == StoreFulfillmentType.delivery) {
      return StoreFulfillmentType.pickupAtBranch;
    }
    return state.fulfillmentType;
  }

  Future<void> openShop(int shopId) async {
    if (state.storefront?.shopId == shopId && state.status == StoreCartStatus.success) {
      return;
    }

    emit(
      state.storefront?.shopId == shopId
          ? state.copyWith(status: StoreCartStatus.loading)
          : StoreCartState(status: StoreCartStatus.loading, cart: state.cart),
    );

    final result = await _getStorefront(shopId);

    result.fold(
      (failure) => emit(
        state.copyWith(status: StoreCartStatus.failure, errorMessage: failure.message),
      ),
      (storefront) => emit(
        state.copyWith(status: StoreCartStatus.success, storefront: storefront),
      ),
    );

    await loadCart();
  }

  Future<void> setQuantity(int productId, int minOrderQty, int quantity) async {
    if (state.isUpdatingCart) return;

    final clamped = quantity <= 0
        ? 0
        : (quantity < minOrderQty ? minOrderQty : quantity);

    final quantities = {
      for (final line in state.cart.lines) line.productId: line.quantity,
    };
    if (clamped == 0) {
      quantities.remove(productId);
    } else {
      quantities[productId] = clamped;
    }

    emit(state.copyWith(isUpdatingCart: true));

    final result = await _putCart(quantities);

    result.fold(
      (failure) => emit(
        state.copyWith(isUpdatingCart: false, errorMessage: failure.message),
      ),
      (cart) => emit(
        state.copyWith(
          isUpdatingCart: false,
          cart: cart,
          fulfillmentType: _resolveFulfillmentType(cart),
        ),
      ),
    );
  }

  Future<void> clearCart() async {
    if (state.cart.isEmpty || state.isUpdatingCart) return;

    emit(state.copyWith(isUpdatingCart: true));

    final result = await _putCart(const {});

    result.fold(
      (failure) => emit(
        state.copyWith(isUpdatingCart: false, errorMessage: failure.message),
      ),
      (cart) => emit(
        state.copyWith(
          isUpdatingCart: false,
          cart: cart,
          fulfillmentType: _resolveFulfillmentType(cart),
        ),
      ),
    );
  }

  void setFulfillmentType(StoreFulfillmentType? type) {
    if (type == StoreFulfillmentType.delivery && !state.cart.deliveryOffered) {
      return;
    }
    emit(
      state.copyWith(fulfillmentType: type, clearFulfillmentType: type == null),
    );
  }

  void setPaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: method));
  }

  void setDeliveryLocation({String? address, double? lat, double? lng}) {
    emit(
      state.copyWith(
        deliveryAddress: address ?? state.deliveryAddress,
        deliveryLat: lat ?? state.deliveryLat,
        deliveryLng: lng ?? state.deliveryLng,
      ),
    );
  }

  void setNote(String note) => emit(state.copyWith(note: note));

  void search(String query) => emit(state.copyWith(search: query));

  void filterByCategory(int? categoryId) => emit(
    state.copyWith(categoryId: categoryId, clearCategoryId: categoryId == null),
  );

  Future<StoreOrder?> submitOrder() async {
    if (state.cart.isEmpty) return null;

    emit(state.copyWith(isSubmitting: true));

    final result = await _checkout(
      fulfillmentType: state.fulfillmentType,
      paymentMethod: state.paymentMethod,
      deliveryAddress: state.checkoutDeliveryAddress,
      deliveryLat: state.checkoutDeliveryLat,
      deliveryLng: state.checkoutDeliveryLng,
      note: state.checkoutNote,
    );

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
        return null;
      },
      (result) {
        emit(
          state.copyWith(
            isSubmitting: false,
            cart: StoreCart.empty,
            placedOrder: result.$1,
            placedOrderMessage: result.$2,
          ),
        );
        return result.$1;
      },
    );
  }

  void reset() => emit(const StoreCartState());
}
