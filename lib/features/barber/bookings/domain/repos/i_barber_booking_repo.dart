import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../entities/booking_addon.dart';
import '../entities/booking_adjustment.dart';
import '../entities/booking_drink.dart';
import '../entities/booking_settle_item.dart';
import '../entities/booking_status.dart';
import '../entities/unresolved_bookings_page.dart';
import '../entities/walk_in_option.dart';

abstract class IBarberBookingRepo {
  Future<Either<Failure, List<Booking>>> getBookings({
    String? date,
    BookingStatus? status,
  });

  Future<Either<Failure, List<Booking>>> getPendingBookings();

  Future<Either<Failure, UnresolvedBookingsPage>> getUnresolvedBookings({
    required int page,
    required int size,
  });

  Future<Either<Failure, Unit>> settleBookings(List<BookingSettleItem> items);

  Future<Either<Failure, List<Booking>>> getQueue(String date);

  Future<Either<Failure, Booking>> getBooking(int id);

  Future<Either<Failure, Booking>> confirmBooking(int id);

  Future<Either<Failure, Booking>> rejectBooking(int id, String reason);

  Future<Either<Failure, Booking>> advanceStatus(int id, BookingStatus status);

  Future<Either<Failure, List<WalkInOption>>> getWalkInOptions();

  Future<Either<Failure, Booking>> createWalkIn({
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
  });

  Future<Either<Failure, Booking>> updateBilling({
    required int id,
    required List<BookingDrink> drinks,
    required List<BookingAddon> addons,
    required List<BookingAdjustment> adjustments,
  });
}
