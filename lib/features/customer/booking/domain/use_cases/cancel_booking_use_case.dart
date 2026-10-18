import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_booking.dart';
import '../repos/i_customer_booking_repo.dart';

class CancelBookingUseCase {
  final ICustomerBookingRepo _repo;

  CancelBookingUseCase(this._repo);

  Future<Either<Failure, CustomerBooking>> call(int id) =>
      _repo.cancelBooking(id);
}
