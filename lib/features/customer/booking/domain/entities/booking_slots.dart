import 'package:equatable/equatable.dart';
import 'booking_slot_barber.dart';

class BookingSlots extends Equatable {
  final String date;
  final int serviceTypeId;
  final List<BookingSlotBarber> perBarber;
  final List<String> anyBarberSlots;

  const BookingSlots({
    required this.date,
    required this.serviceTypeId,
    required this.perBarber,
    required this.anyBarberSlots,
  });

  @override
  List<Object?> get props => [date, serviceTypeId, perBarber, anyBarberSlots];
}
