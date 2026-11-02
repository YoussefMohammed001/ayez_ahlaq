import '../../domain/entities/booking_slot_barber.dart';
import 'booking_slot_window_model.dart';

class BookingSlotBarberModel extends BookingSlotBarber {
  const BookingSlotBarberModel({
    required super.barberId,
    required super.barberName,
    required super.durationMinutes,
    required super.slots,
    super.windows,
  });

  factory BookingSlotBarberModel.fromJson(Map<String, dynamic> json) {
    return BookingSlotBarberModel(
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      slots: (json['slots'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
      windows: (json['windows'] as List<dynamic>? ?? [])
          .map(
            (e) => BookingSlotWindowModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
