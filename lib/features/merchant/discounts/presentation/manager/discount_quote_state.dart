import 'package:equatable/equatable.dart';
import '../../domain/entities/discount_quote.dart';

enum DiscountQuoteStatus { initial, loading, success, failure }

class DiscountQuoteState extends Equatable {
  final DiscountQuoteStatus status;
  final DiscountQuote? quote;
  final Map<int, int> items;
  final int? shopId;
  final String? errorMessage;

  const DiscountQuoteState({
    this.status = DiscountQuoteStatus.initial,
    this.quote,
    this.items = const {},
    this.shopId,
    this.errorMessage,
  });

  bool get hasItems => items.isNotEmpty;

  DiscountQuoteState copyWith({
    DiscountQuoteStatus? status,
    DiscountQuote? quote,
    Map<int, int>? items,
    int? shopId,
    bool clearShop = false,
    String? errorMessage,
  }) {
    return DiscountQuoteState(
      status: status ?? this.status,
      quote: quote ?? this.quote,
      items: items ?? this.items,
      shopId: clearShop ? null : (shopId ?? this.shopId),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, quote, items, shopId, errorMessage];
}
