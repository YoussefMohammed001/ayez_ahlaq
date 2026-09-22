import '../../domain/entities/customer_booking.dart';

class SameDayBookingChecker {
  const SameDayBookingChecker._();

  static bool hasConflict(List<CustomerBooking> bookings, String date) {
    return bookings.any(
      (booking) => !booking.status.isPast && booking.bookingDate == date,
    );
  }
}
