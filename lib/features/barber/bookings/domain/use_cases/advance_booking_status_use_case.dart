import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../entities/booking_status.dart';
import '../repos/i_barber_booking_repo.dart';

class AdvanceBookingStatusUseCase {
  final IBarberBookingRepo _repo;

  AdvanceBookingStatusUseCase(this._repo);

  Future<Either<Failure, Booking>> call(int id, BookingStatus status) =>
      _repo.advanceStatus(id, status);
}
