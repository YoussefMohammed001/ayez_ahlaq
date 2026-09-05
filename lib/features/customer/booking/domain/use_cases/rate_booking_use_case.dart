import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/rating_target.dart';
import '../repos/i_customer_booking_repo.dart';

class RateBookingUseCase {
  final ICustomerBookingRepo _repo;

  RateBookingUseCase(this._repo);

  Future<Either<Failure, Unit>> call({
    required int bookingId,
    required RatingTarget target,
    required int stars,
    String? note,
  }) => _repo.rateBooking(
    bookingId: bookingId,
    target: target,
    stars: stars,
    note: note,
  );
}
