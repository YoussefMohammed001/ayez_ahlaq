import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../entities/booking_addon.dart';
import '../entities/booking_drink.dart';
import '../repos/i_barber_booking_repo.dart';

class CreateWalkInUseCase {
  final IBarberBookingRepo _repo;

  CreateWalkInUseCase(this._repo);

  Future<Either<Failure, Booking>> call({
    required int barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    String? customerName,
    String? customerPhone,
    String? slotTime,
    required String paymentMethod,
    String? note,
    required List<BookingAddon> addons,
    required List<BookingDrink> drinks,
  }) => _repo.createWalkIn(
    barberId: barberId,
    serviceTypeId: serviceTypeId,
    haircutStyleId: haircutStyleId,
    customerName: customerName,
    customerPhone: customerPhone,
    slotTime: slotTime,
    paymentMethod: paymentMethod,
    note: note,
    addons: addons,
    drinks: drinks,
  );
}
