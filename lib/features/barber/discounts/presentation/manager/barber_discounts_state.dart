import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_discount.dart';

enum BarberDiscountsStatus { initial, loading, success, failure }

class BarberDiscountsState extends Equatable {
  final BarberDiscountsStatus status;
  final List<BarberDiscount> discounts;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberDiscountsState({
    this.status = BarberDiscountsStatus.initial,
    this.discounts = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  List<BarberDiscount> get liveDiscounts =>
      discounts.where((d) => d.liveNow).toList();

  List<BarberDiscount> get closedDiscounts =>
      discounts.where((d) => d.isClosed).toList();

  BarberDiscountsState copyWith({
    BarberDiscountsStatus? status,
    List<BarberDiscount>? discounts,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberDiscountsState(
      status: status ?? this.status,
      discounts: discounts ?? this.discounts,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, discounts, errorMessage, isSubmitting];
}
