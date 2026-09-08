import '../../domain/entities/booking_adjustment.dart';

class BookingAdjustmentModel extends BookingAdjustment {
  const BookingAdjustmentModel({
    required super.label,
    required super.amount,
  });

  factory BookingAdjustmentModel.fromJson(Map<String, dynamic> json) {
    return BookingAdjustmentModel(
      label: json['label'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
    );
  }
}
