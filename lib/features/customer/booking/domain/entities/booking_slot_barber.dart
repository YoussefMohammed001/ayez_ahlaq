import 'package:equatable/equatable.dart';

class BookingSlotBarber extends Equatable {
  final int barberId;
  final String barberName;
  final int durationMinutes;
  final List<String> slots;

  const BookingSlotBarber({
    required this.barberId,
    required this.barberName,
    required this.durationMinutes,
    required this.slots,
  });

  @override
  List<Object?> get props => [barberId, barberName, durationMinutes, slots];
}
