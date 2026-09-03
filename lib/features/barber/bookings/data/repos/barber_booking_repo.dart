import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_status.dart';
import '../../domain/repos/i_barber_booking_repo.dart';
import '../apis/barber_booking_api.dart';
import '../models/booking_model.dart';

class BarberBookingRepo implements IBarberBookingRepo {
  final BarberBookingApi _api;

  BarberBookingRepo(this._api);

  @override
  Future<Either<Failure, List<Booking>>> getBookings({
    String? date,
    BookingStatus? status,
  }) async {
    final result = await _api.getBookings(date: date, status: status);
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, List<Booking>>> getPendingBookings() async {
    final result = await _api.getPendingBookings();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, List<Booking>>> getQueue(String date) async {
    final result = await _api.getQueue(date);
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, Booking>> getBooking(int id) async {
    final result = await _api.getBooking(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> confirmBooking(int id) async {
    final result = await _api.confirmBooking(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> rejectBooking(int id, String reason) async {
    final result = await _api.rejectBooking(id, reason);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> advanceStatus(
    int id,
    BookingStatus status,
  ) async {
    final result = await _api.advanceStatus(id, status);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> createWalkIn({
    int? barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    required String customerName,
    required String customerPhone,
    required String paymentMethod,
    String? note,
    required List<BookingAddon> addons,
  }) async {
    final result = await _api.createWalkIn(
      barberId: barberId,
      serviceTypeId: serviceTypeId,
      haircutStyleId: haircutStyleId,
      customerName: customerName,
      customerPhone: customerPhone,
      paymentMethod: paymentMethod,
      note: note,
      addons: addons
          .map((a) => {'productId': a.productId, 'quantity': a.quantity})
          .toList(),
    );
    return result.map(_mapOne);
  }

  List<Booking> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<Booking>(
          (e) => BookingModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Booking _mapOne(dynamic response) {
    return BookingModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
