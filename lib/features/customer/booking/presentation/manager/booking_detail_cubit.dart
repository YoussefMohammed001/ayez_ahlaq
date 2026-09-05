import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/rating_target.dart';
import '../../domain/use_cases/cancel_booking_use_case.dart';
import '../../domain/use_cases/get_booking_use_case.dart';
import '../../domain/use_cases/rate_booking_use_case.dart';
import 'booking_detail_state.dart';

class BookingDetailCubit extends Cubit<BookingDetailState> {
  final GetBookingUseCase _getBooking;
  final CancelBookingUseCase _cancelBooking;
  final RateBookingUseCase _rateBooking;

  BookingDetailCubit(this._getBooking, this._cancelBooking, this._rateBooking)
    : super(const BookingDetailState());

  Future<void> loadBooking(int id) async {
    emit(state.copyWith(status: BookingDetailStatus.loading));

    final result = await _getBooking(id);

    result.fold(
      (failure) => emit(
        state.copyWith(status: BookingDetailStatus.failure, errorMessage: failure.message),
      ),
      (booking) => emit(
        state.copyWith(status: BookingDetailStatus.success, booking: booking),
      ),
    );
  }

  Future<bool> cancelBooking(int id) async {
    emit(state.copyWith(isCancelling: true));

    final result = await _cancelBooking(id);

    return result.fold(
      (failure) {
        emit(state.copyWith(isCancelling: false, errorMessage: failure.message));
        return false;
      },
      (booking) {
        emit(state.copyWith(isCancelling: false, booking: booking, errorMessage: null));
        return true;
      },
    );
  }

  Future<bool> rateBooking({
    required RatingTarget target,
    required int stars,
    String? note,
  }) async {
    final booking = state.booking;
    if (booking == null) return false;

    emit(state.copyWith(isRating: true));

    final result = await _rateBooking(
      bookingId: booking.id,
      target: target,
      stars: stars,
      note: note,
    );

    return result.fold(
      (failure) {
        emit(state.copyWith(isRating: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(
          state.copyWith(
            isRating: false,
            booking: booking.copyWith(
              ratedBarber: target == RatingTarget.barber ? true : null,
              ratedShop: target == RatingTarget.shop ? true : null,
            ),
            errorMessage: null,
          ),
        );
        return true;
      },
    );
  }
}
