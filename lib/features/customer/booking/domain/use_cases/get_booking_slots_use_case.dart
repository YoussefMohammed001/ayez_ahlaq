import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking_slots.dart';
import '../repos/i_customer_booking_repo.dart';

class GetBookingSlotsUseCase {
  final ICustomerBookingRepo _repo;

  GetBookingSlotsUseCase(this._repo);

  Future<Either<Failure, BookingSlots>> call({
    required int shopId,
    required int serviceTypeId,
    required String date,
  }) =>
      _repo.getSlots(shopId: shopId, serviceTypeId: serviceTypeId, date: date);
}
