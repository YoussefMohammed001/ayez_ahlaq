import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_line.dart';
import '../../domain/entities/fulfillment_type.dart';
import '../../domain/entities/store_merchant.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_product.dart';
import '../../domain/use_cases/get_merchant_products_use_case.dart';
import '../../domain/use_cases/place_store_order_use_case.dart';
import '../../domain/use_cases/quote_cart_use_case.dart';
import 'barber_store_cart_state.dart';

class BarberStoreCartCubit extends Cubit<BarberStoreCartState> {
  final GetMerchantProductsUseCase _getProducts;
  final QuoteCartUseCase _quoteCart;
  final PlaceStoreOrderUseCase _placeOrder;

  BarberStoreCartCubit(this._getProducts, this._quoteCart, this._placeOrder)
      : super(const BarberStoreCartState());

  Future<void> openMerchant(StoreMerchant merchant) async {
    if (state.merchant?.id == merchant.id && state.products.isNotEmpty) {
      return;
    }

    emit(
      BarberStoreCartState(
        status: BarberStoreCartStatus.loading,
        merchant: merchant,
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
  }

  void setQuantity(StoreProduct product, int quantity) {
    emit(state.copyWith(lines: _withQuantity(state.lines, product, quantity)));
  }

  List<CartLine> _withQuantity(
    List<CartLine> lines,
    StoreProduct product,
    int quantity,
  ) {
    if (quantity <= 0) {
      return lines.where((line) => line.product.id != product.id).toList();
    }

    final clamped = quantity < product.minOrderQty
        ? product.minOrderQty
        : quantity;
    final index = lines.indexWhere((line) => line.product.id == product.id);

    if (index == -1) {
      return [...lines, CartLine(product: product, quantity: clamped)];
    }

    return [
      for (final line in lines)
        if (line.product.id == product.id)
          line.copyWith(quantity: clamped)
        else
          line,
    ];
  }

  void setFulfillmentType(FulfillmentType? type) {
    emit(
      state.copyWith(fulfillmentType: type, clearFulfillmentType: type == null),
    );
  }

  void setNote(String note) => emit(state.copyWith(note: note));

  Future<void> refreshQuote() async {
    final merchant = state.merchant;
    if (merchant == null || state.lines.isEmpty) {
      emit(state.copyWith(clearQuote: true));
      return;
    }

    emit(state.copyWith(isQuoting: true));

    final result = await _quoteCart(
      merchantId: merchant.id,
      fulfillmentType: state.fulfillmentType,
      lines: state.lines,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isQuoting: false, errorMessage: failure.message),
      ),
      (quote) => emit(state.copyWith(isQuoting: false, quote: quote)),
    );
  }

  Future<StoreOrder?> submitOrder() async {
    final merchant = state.merchant;
    if (merchant == null || state.lines.isEmpty) return null;

    emit(state.copyWith(isSubmitting: true));

    final result = await _placeOrder(
      merchantId: merchant.id,
      fulfillmentType: state.fulfillmentType,
      lines: state.lines,
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
        emit(state.copyWith(isSubmitting: false));
        return order;
      },
    );
  }

  void reset() => emit(const BarberStoreCartState());
}
