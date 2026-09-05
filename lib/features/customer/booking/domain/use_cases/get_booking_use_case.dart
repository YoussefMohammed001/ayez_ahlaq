import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_booking.dart';
import '../repos/i_customer_booking_repo.dart';

class GetBookingUseCase {
  final ICustomerBookingRepo _repo;

  GetBookingUseCase(this._repo);

  Future<Either<Failure, CustomerBooking>> call(int id) => _repo.getBooking(id);
}
