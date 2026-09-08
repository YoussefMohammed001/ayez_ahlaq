import 'package:equatable/equatable.dart';

class BookingAdjustment extends Equatable {
  final String label;
  final int amount;

  const BookingAdjustment({required this.label, required this.amount});

  bool get isDiscount => amount < 0;

  @override
  List<Object?> get props => [label, amount];
}
