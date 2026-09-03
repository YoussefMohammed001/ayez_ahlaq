import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../repos/i_barber_booking_repo.dart';

class GetQueueUseCase {
  final IBarberBookingRepo _repo;

  GetQueueUseCase(this._repo);

  Future<Either<Failure, List<Booking>>> call(String date) =>
      _repo.getQueue(date);
}
