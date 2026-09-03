import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../repos/i_barber_booking_repo.dart';

class GetBookingUseCase {
  final IBarberBookingRepo _repo;

  GetBookingUseCase(this._repo);

  Future<Either<Failure, Booking>> call(int id) => _repo.getBooking(id);
}
