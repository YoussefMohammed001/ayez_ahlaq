import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../entities/booking_addon.dart';
import '../repos/i_barber_booking_repo.dart';

class CreateWalkInUseCase {
  final IBarberBookingRepo _repo;

  CreateWalkInUseCase(this._repo);

  Future<Either<Failure, Booking>> call({
    int? barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    required String customerName,
    required String customerPhone,
    required String paymentMethod,
    String? note,
    required List<BookingAddon> addons,
  }) => _repo.createWalkIn(
    barberId: barberId,
    serviceTypeId: serviceTypeId,
    haircutStyleId: haircutStyleId,
    customerName: customerName,
    customerPhone: customerPhone,
    paymentMethod: paymentMethod,
    note: note,
    addons: addons,
  );
}
