import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/booking_slots.dart';
import '../../domain/entities/customer_booking.dart';
import '../../domain/entities/rating_target.dart';
import '../../domain/repos/i_customer_booking_repo.dart';
import '../apis/customer_booking_api.dart';
import '../models/booking_slots_model.dart';
import '../models/customer_booking_model.dart';

class CustomerBookingRepo implements ICustomerBookingRepo {
  final CustomerBookingApi _api;

  CustomerBookingRepo(this._api);

  @override
  Future<Either<Failure, BookingSlots>> getSlots({
    required int shopId,
    required int serviceTypeId,
    required String date,
  }) async {
    final result = await _api.getSlots(
      shopId: shopId,
      serviceTypeId: serviceTypeId,
      date: date,
    );

    return result.map(
      (response) =>
          BookingSlotsModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
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
  }) async {
    final result = await _api.createBooking({
      'shopId': shopId,
      'autoSelect': autoSelect,
      'barberId': barberId,
      'serviceTypeId': serviceTypeId,
      'haircutStyleId': haircutStyleId,
      'date': date,
      'slotTime': slotTime,
      'paymentMethod': paymentMethod,
      'note': note,
      'addons': const [],
    });

    return result.map(
      (response) =>
          CustomerBookingModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, List<CustomerBooking>>> getBookings() async {
    final result = await _api.getBookings();

    return result.map(
      (response) => (response['data'] as List<dynamic>? ?? [])
          .map((e) => CustomerBookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, CustomerBooking>> getBooking(int id) async {
    final result = await _api.getBooking(id);

    return result.map(
      (response) =>
          CustomerBookingModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, CustomerBooking>> cancelBooking(int id) async {
    final result = await _api.cancelBooking(id);

    return result.map(
      (response) =>
          CustomerBookingModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Unit>> rateBooking({
    required int bookingId,
    required RatingTarget target,
    required int stars,
    String? note,
  }) async {
    final result = await _api.rateBooking({
      'bookingId': bookingId,
      'target': target.toApi,
      'stars': stars,
      'note': note,
    });

    return result.map((_) => unit);
  }
}
