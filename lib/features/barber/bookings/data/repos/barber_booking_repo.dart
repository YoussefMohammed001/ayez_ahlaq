import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_adjustment.dart';
import '../../domain/entities/booking_drink.dart';
import '../../domain/entities/booking_status.dart';
import '../../domain/repos/i_barber_booking_repo.dart';
import '../apis/barber_booking_api.dart';
import '../models/booking_model.dart';
import 'barber_booking_walk_in_mixin.dart';

class BarberBookingRepo with BarberBookingWalkInMixin implements IBarberBookingRepo {
  @override
  final BarberBookingApi api;

  BarberBookingRepo(this.api);

  @override
  Future<Either<Failure, List<Booking>>> getBookings({
    String? date,
    BookingStatus? status,
  }) async {
    final result = await api.getBookings(date: date, status: status);
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, List<Booking>>> getPendingBookings() async {
    final result = await api.getPendingBookings();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, List<Booking>>> getQueue(String date) async {
    final result = await api.getQueue(date);
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, Booking>> getBooking(int id) async {
    final result = await api.getBooking(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> confirmBooking(int id) async {
    final result = await api.confirmBooking(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> rejectBooking(int id, String reason) async {
    final result = await api.rejectBooking(id, reason);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> advanceStatus(
    int id,
    BookingStatus status,
  ) async {
    final result = await api.advanceStatus(id, status);
    return result.flatMap(_mapOne);
  }

  @override
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
  }) async {
    final result = await api.createWalkIn(
      barberId: barberId,
      serviceTypeId: serviceTypeId,
      haircutStyleId: haircutStyleId,
      customerName: customerName,
      customerPhone: customerPhone,
      slotTime: slotTime,
      paymentMethod: paymentMethod,
      note: note,
      addons: addons
          .map((a) => {'productId': a.productId, 'quantity': a.quantity})
          .toList(),
      drinks: drinks
          .map((d) => {'drinkId': d.drinkId, 'quantity': d.quantity})
          .toList(),
    );
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Booking>> updateBilling({
    required int id,
    required List<BookingDrink> drinks,
    required List<BookingAddon> addons,
    required List<BookingAdjustment> adjustments,
  }) async {
    final result = await api.updateBilling(
      id: id,
      drinks: drinks
          .map((d) => {'drinkId': d.drinkId, 'quantity': d.quantity})
          .toList(),
      addons: addons
          .map((a) => {'productId': a.productId, 'quantity': a.quantity})
          .toList(),
      adjustments: adjustments
          .map((a) => {'label': a.label, 'amount': a.amount})
          .toList(),
    );
    return result.flatMap(_mapOne);
  }

  List<Booking> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<Booking>(
          (e) => BookingModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Either<Failure, Booking> _mapOne(dynamic response) {
    return requireDataMap(response).map(BookingModel.fromJson);
  }
}
