import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/cancel_booking_use_case.dart';
import '../../domain/use_cases/get_booking_use_case.dart';
import 'booking_detail_state.dart';

class BookingDetailCubit extends Cubit<BookingDetailState> {
  final GetBookingUseCase _getBooking;
  final CancelBookingUseCase _cancelBooking;

  BookingDetailCubit(this._getBooking, this._cancelBooking)
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
}
