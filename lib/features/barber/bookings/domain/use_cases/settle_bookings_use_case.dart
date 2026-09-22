import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking_settle_item.dart';
import '../repos/i_barber_booking_repo.dart';

class SettleBookingsUseCase {
  final IBarberBookingRepo _repo;

  SettleBookingsUseCase(this._repo);

  Future<Either<Failure, Unit>> call(List<BookingSettleItem> items) =>
      _repo.settleBookings(items);
}
