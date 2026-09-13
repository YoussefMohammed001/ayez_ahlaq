import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking_addon.dart';
import '../entities/booking_drink.dart';
import '../entities/customer_booking.dart';
import '../repos/i_customer_booking_repo.dart';

class CreateBookingUseCase {
  final ICustomerBookingRepo _repo;

  CreateBookingUseCase(this._repo);

  Future<Either<Failure, (CustomerBooking, String)>> call({
    required int shopId,
    required bool autoSelect,
    int? barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    required String date,
    required String slotTime,
    required String paymentMethod,
    String? note,
    List<BookingAddon> addons = const [],
    List<BookingDrink> drinks = const [],
  }) => _repo.createBooking(
    shopId: shopId,
    autoSelect: autoSelect,
    barberId: barberId,
    serviceTypeId: serviceTypeId,
    haircutStyleId: haircutStyleId,
    date: date,
    slotTime: slotTime,
    paymentMethod: paymentMethod,
    note: note,
    addons: addons,
    drinks: drinks,
  );
}
