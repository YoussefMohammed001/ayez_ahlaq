import '../../domain/entities/booking_slots.dart';
import 'booking_slot_barber_model.dart';

class BookingSlotsModel extends BookingSlots {
  const BookingSlotsModel({
    required super.date,
    required super.serviceTypeId,
    required super.perBarber,
    required super.anyBarberSlots,
  });

  factory BookingSlotsModel.fromJson(Map<String, dynamic> json) {
    return BookingSlotsModel(
      date: json['date'] as String? ?? '',
      serviceTypeId: (json['serviceTypeId'] as num?)?.toInt() ?? 0,
      perBarber: (json['perBarber'] as List<dynamic>? ?? [])
          .map(
            (e) => BookingSlotBarberModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      anyBarberSlots: (json['anyBarberSlots'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
    );
  }
}
