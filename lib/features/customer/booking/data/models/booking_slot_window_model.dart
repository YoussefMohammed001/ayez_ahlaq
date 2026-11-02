import '../../domain/entities/booking_slot_window.dart';

class BookingSlotWindowModel extends BookingSlotWindow {
  const BookingSlotWindowModel({
    required super.from,
    required super.to,
    required super.minutes,
    required super.fits,
  });

  factory BookingSlotWindowModel.fromJson(Map<String, dynamic> json) {
    return BookingSlotWindowModel(
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      minutes: (json['minutes'] as num?)?.toInt() ?? 0,
      fits: json['fits'] as bool? ?? false,
    );
  }
}
