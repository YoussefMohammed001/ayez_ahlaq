import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../repos/i_barber_booking_repo.dart';

class ConfirmBookingUseCase {
  final IBarberBookingRepo _repo;

  ConfirmBookingUseCase(this._repo);

  Future<Either<Failure, Booking>> call(int id) => _repo.confirmBooking(id);
}
