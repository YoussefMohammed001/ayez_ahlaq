import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../entities/booking_status.dart';
import '../repos/i_barber_booking_repo.dart';

class GetBookingsUseCase {
  final IBarberBookingRepo _repo;

  GetBookingsUseCase(this._repo);

  Future<Either<Failure, List<Booking>>> call({
    String? date,
    BookingStatus? status,
  }) => _repo.getBookings(date: date, status: status);
}
