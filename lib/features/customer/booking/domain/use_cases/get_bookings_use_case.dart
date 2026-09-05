import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_booking.dart';
import '../repos/i_customer_booking_repo.dart';

class GetBookingsUseCase {
  final ICustomerBookingRepo _repo;

  GetBookingsUseCase(this._repo);

  Future<Either<Failure, List<CustomerBooking>>> call() => _repo.getBookings();
}
