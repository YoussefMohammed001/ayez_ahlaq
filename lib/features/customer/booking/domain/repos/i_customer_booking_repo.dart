import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking_addon.dart';
import '../entities/booking_slots.dart';
import '../entities/customer_booking.dart';
import '../entities/rating_target.dart';

abstract class ICustomerBookingRepo {
  Future<Either<Failure, BookingSlots>> getSlots({
    required int shopId,
    required int serviceTypeId,
    required String date,
  });

  Future<Either<Failure, CustomerBooking>> createBooking({
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
  });

  Future<Either<Failure, List<CustomerBooking>>> getBookings();

  Future<Either<Failure, CustomerBooking>> getBooking(int id);

  Future<Either<Failure, CustomerBooking>> cancelBooking(int id);

  Future<Either<Failure, Unit>> rateBooking({
    required int bookingId,
    required RatingTarget target,
    required int stars,
    String? note,
  });
}
