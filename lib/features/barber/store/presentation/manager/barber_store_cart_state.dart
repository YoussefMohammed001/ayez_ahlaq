import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_line.dart';
import '../../domain/entities/cart_quote.dart';
import '../../domain/entities/fulfillment_type.dart';
import '../../domain/entities/store_merchant.dart';
import '../../domain/entities/store_product.dart';

enum BarberStoreCartStatus { initial, loading, success, failure }

class BarberStoreCartState extends Equatable {
  final BarberStoreCartStatus status;
  final StoreMerchant? merchant;
  final List<StoreProduct> products;
  final List<CartLine> lines;
  final FulfillmentType? fulfillmentType;
  final CartQuote? quote;
  final String note;
  final bool isQuoting;
  final bool isSubmitting;
  final String? errorMessage;

  const BarberStoreCartState({
    this.status = BarberStoreCartStatus.initial,
    this.merchant,
    this.products = const [],
    this.lines = const [],
    this.fulfillmentType,
    this.quote,
    this.note = '',
    this.isQuoting = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  int get itemCount => lines.fold(0, (sum, line) => sum + line.quantity);

  int get subtotal => lines.fold(0, (sum, line) => sum + line.lineTotal);

  BarberStoreCartState copyWith({
    BarberStoreCartStatus? status,
    StoreMerchant? merchant,
    List<StoreProduct>? products,
    List<CartLine>? lines,
    FulfillmentType? fulfillmentType,
    bool clearFulfillmentType = false,
    CartQuote? quote,
    bool clearQuote = false,
    String? note,
    bool? isQuoting,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return BarberStoreCartState(
      status: status ?? this.status,
      merchant: merchant ?? this.merchant,
      products: products ?? this.products,
      lines: lines ?? this.lines,
      fulfillmentType: clearFulfillmentType
          ? null
          : (fulfillmentType ?? this.fulfillmentType),
      quote: clearQuote ? null : (quote ?? this.quote),
      note: note ?? this.note,
      isQuoting: isQuoting ?? this.isQuoting,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    merchant,
    products,
    lines,
    fulfillmentType,
    quote,
    note,
    isQuoting,
    isSubmitting,
    errorMessage,
  ];
}
