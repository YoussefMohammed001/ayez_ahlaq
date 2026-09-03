import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../repos/i_barber_booking_repo.dart';

class RejectBookingUseCase {
  final IBarberBookingRepo _repo;

  RejectBookingUseCase(this._repo);

  Future<Either<Failure, Booking>> call(int id, String reason) =>
      _repo.rejectBooking(id, reason);
}
