import 'package:equatable/equatable.dart';
import 'booking_slot_window.dart';

class BookingSlotBarber extends Equatable {
  final int barberId;
  final String barberName;
  final int durationMinutes;
  final List<String> slots;
  final List<BookingSlotWindow> windows;

  const BookingSlotBarber({
    required this.barberId,
    required this.barberName,
    required this.durationMinutes,
    required this.slots,
    this.windows = const [],
  });

  @override
  List<Object?> get props => [
    barberId,
    barberName,
    durationMinutes,
    slots,
    windows,
  ];
}
