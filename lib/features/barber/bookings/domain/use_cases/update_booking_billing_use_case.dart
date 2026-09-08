import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../entities/booking_addon.dart';
import '../entities/booking_adjustment.dart';
import '../entities/booking_drink.dart';
import '../repos/i_barber_booking_repo.dart';

class UpdateBookingBillingUseCase {
  final IBarberBookingRepo _repo;

  UpdateBookingBillingUseCase(this._repo);

  Future<Either<Failure, Booking>> call({
    required int id,
    required List<BookingDrink> drinks,
    required List<BookingAddon> addons,
    required List<BookingAdjustment> adjustments,
  }) => _repo.updateBilling(
    id: id,
    drinks: drinks,
    addons: addons,
    adjustments: adjustments,
  );
}
