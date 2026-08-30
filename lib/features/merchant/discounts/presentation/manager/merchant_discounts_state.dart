import 'package:equatable/equatable.dart';
import '../../domain/entities/discount.dart';
import '../../domain/entities/discount_shop.dart';

enum DiscountsStatus { initial, loading, success, failure }

class MerchantDiscountsState extends Equatable {
  final DiscountsStatus status;
  final List<Discount> discounts;
  final List<DiscountShop> shops;
  final String? errorMessage;
  final bool isSubmitting;

  const MerchantDiscountsState({
    this.status = DiscountsStatus.initial,
    this.discounts = const [],
    this.shops = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  List<Discount> get liveDiscounts =>
      discounts.where((d) => d.liveNow).toList();

  List<Discount> get closedDiscounts =>
      discounts.where((d) => d.isClosed).toList();

  MerchantDiscountsState copyWith({
    DiscountsStatus? status,
    List<Discount>? discounts,
    List<DiscountShop>? shops,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MerchantDiscountsState(
      status: status ?? this.status,
      discounts: discounts ?? this.discounts,
      shops: shops ?? this.shops,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    discounts,
    shops,
    errorMessage,
    isSubmitting,
  ];
}
