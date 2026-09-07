import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/fulfillment_type.dart';
import '../../domain/entities/store_merchant.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/use_cases/checkout_cart_use_case.dart';
import '../../domain/use_cases/get_cart_use_case.dart';
import '../../domain/use_cases/get_merchant_products_use_case.dart';
import '../../domain/use_cases/put_cart_use_case.dart';
import 'barber_store_cart_state.dart';

class BarberStoreCartCubit extends Cubit<BarberStoreCartState> {
  final GetMerchantProductsUseCase _getProducts;
  final GetCartUseCase _getCart;
  final PutCartUseCase _putCart;
  final CheckoutCartUseCase _checkout;

  BarberStoreCartCubit(
    this._getProducts,
    this._getCart,
    this._putCart,
    this._checkout,
  ) : super(const BarberStoreCartState());

  Future<void> loadCart() async {
    final result = await _getCart();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (cart) => emit(state.copyWith(cart: cart, fulfillmentType: _resolveFulfillmentType(cart))),
    );
  }

  FulfillmentType? _resolveFulfillmentType(Cart cart) {
    if (!cart.deliveryOffered && state.fulfillmentType == FulfillmentType.delivery) {
      return FulfillmentType.pickupAtBranch;
    }
    return state.fulfillmentType;
  }

  Future<void> openMerchant(StoreMerchant merchant) async {
    if (state.merchant?.id == merchant.id && state.products.isNotEmpty) {
      return;
    }

    emit(
      BarberStoreCartState(
        status: BarberStoreCartStatus.loading,
        merchant: merchant,
        cart: state.cart,
      ),
    );

    final result = await _getProducts(merchant.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberStoreCartStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          status: BarberStoreCartStatus.success,
          products: products,
        ),
      ),
    );

    await loadCart();
  }

  Future<void> setQuantity(int productId, int minOrderQty, int quantity) async {
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

  void setFulfillmentType(FulfillmentType? type) {
    if (type == FulfillmentType.delivery && !state.cart.deliveryOffered) {
      return;
    }
    emit(
      state.copyWith(fulfillmentType: type, clearFulfillmentType: type == null),
    );
  }

  void setNote(String note) => emit(state.copyWith(note: note));

  Future<StoreOrder?> submitOrder() async {
    if (state.cart.isEmpty) return null;

    emit(state.copyWith(isSubmitting: true));

    final result = await _checkout(
      fulfillmentType: state.fulfillmentType,
      note: state.note.isEmpty ? null : state.note,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return null;
      },
      (order) {
        emit(state.copyWith(isSubmitting: false, cart: Cart.empty));
        return order;
      },
    );
  }

  void reset() => emit(const BarberStoreCartState());
}
