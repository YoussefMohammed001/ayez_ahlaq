import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_bookings_use_case.dart';
import 'my_bookings_state.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  final GetBookingsUseCase _getBookings;

  MyBookingsCubit(this._getBookings) : super(const MyBookingsState());

  Future<void> loadBookings() async {
    emit(state.copyWith(status: MyBookingsStatus.loading));

    final result = await _getBookings();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MyBookingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (bookings) => emit(
        state.copyWith(status: MyBookingsStatus.success, bookings: bookings),
      ),
    );
  }
}
