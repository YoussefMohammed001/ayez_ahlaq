import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/quote_discount_use_case.dart';
import 'discount_quote_state.dart';

class DiscountQuoteCubit extends Cubit<DiscountQuoteState> {
  final QuoteDiscountUseCase _quote;

  DiscountQuoteCubit(this._quote) : super(const DiscountQuoteState());

  void setQuantity(int productId, int quantity) {
    final items = Map<int, int>.from(state.items);
    if (quantity > 0) {
      items[productId] = quantity;
    } else {
      items.remove(productId);
    }
    emit(state.copyWith(items: items));
  }

  void setShop(int? shopId) {
    emit(state.copyWith(shopId: shopId, clearShop: shopId == null));
  }

  Future<void> refreshQuote() async {
    if (!state.hasItems) {
      emit(state.copyWith(status: DiscountQuoteStatus.initial));
      return;
    }

    emit(state.copyWith(status: DiscountQuoteStatus.loading));

    final result = await _quote(shopId: state.shopId, items: state.items);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DiscountQuoteStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (quote) => emit(
        state.copyWith(status: DiscountQuoteStatus.success, quote: quote),
      ),
    );
  }
}
