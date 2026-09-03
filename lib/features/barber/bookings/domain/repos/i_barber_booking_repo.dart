import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/booking.dart';
import '../entities/booking_addon.dart';
import '../entities/booking_status.dart';

abstract class IBarberBookingRepo {
  Future<Either<Failure, List<Booking>>> getBookings({
    String? date,
    BookingStatus? status,
  });

  Future<Either<Failure, List<Booking>>> getPendingBookings();

  Future<Either<Failure, List<Booking>>> getQueue(String date);

  Future<Either<Failure, Booking>> getBooking(int id);

  Future<Either<Failure, Booking>> confirmBooking(int id);

  Future<Either<Failure, Booking>> rejectBooking(int id, String reason);

  Future<Either<Failure, Booking>> advanceStatus(int id, BookingStatus status);

  Future<Either<Failure, Booking>> createWalkIn({
    int? barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    required String customerName,
    required String customerPhone,
    required String paymentMethod,
    String? note,
    required List<BookingAddon> addons,
  });
}
