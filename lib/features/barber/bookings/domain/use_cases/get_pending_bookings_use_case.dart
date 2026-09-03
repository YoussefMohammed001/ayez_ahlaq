import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../repos/i_barber_booking_repo.dart';

class GetPendingBookingsUseCase {
  final IBarberBookingRepo _repo;

  GetPendingBookingsUseCase(this._repo);

  Future<Either<Failure, List<Booking>>> call() => _repo.getPendingBookings();
}
