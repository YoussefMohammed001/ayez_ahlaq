import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/booking_settle_item.dart';
import '../../domain/entities/unresolved_bookings_page.dart';
import '../../domain/entities/walk_in_option.dart';
import '../apis/barber_booking_api.dart';
import '../models/unresolved_bookings_page_model.dart';
import '../models/walk_in_option_model.dart';

mixin BarberBookingWalkInMixin {
  BarberBookingApi get api;

  Future<Either<Failure, List<WalkInOption>>> getWalkInOptions() async {
    final result = await api.getWalkInOptions();
    return result.map(_mapWalkInOptions);
  }

  Future<Either<Failure, UnresolvedBookingsPage>> getUnresolvedBookings({
    required int page,
    required int size,
  }) async {
    final result = await api.getUnresolvedBookings(page: page, size: size);
    return result.flatMap(_mapUnresolvedPage);
  }

  Future<Either<Failure, Unit>> settleBookings(
    List<BookingSettleItem> items,
  ) async {
    final result = await api.settleBookings(
      items.map((item) => item.toJson()).toList(),
    );
    return result.map((_) => unit);
  }

  Either<Failure, UnresolvedBookingsPage> _mapUnresolvedPage(dynamic response) {
    return requireDataMap(response).map(UnresolvedBookingsPageModel.fromJson);
  }

  List<WalkInOption> _mapWalkInOptions(dynamic response) {
    final data = response is List ? response : response['data'] as List? ?? const [];
    return data
        .map<WalkInOption>(
          (e) => WalkInOptionModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
