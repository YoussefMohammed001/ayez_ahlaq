import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_booking.dart';
import '../repos/i_customer_booking_repo.dart';

class CreateBookingUseCase {
  final ICustomerBookingRepo _repo;

  CreateBookingUseCase(this._repo);

  Future<Either<Failure, CustomerBooking>> call({
    required int shopId,
    required bool autoSelect,
    int? barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    required String date,
    required String slotTime,
    required String paymentMethod,
    String? note,
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
  );
}
