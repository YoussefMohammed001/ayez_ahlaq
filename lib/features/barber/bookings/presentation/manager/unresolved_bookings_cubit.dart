import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/booking_settle_decision.dart';
import '../../domain/entities/booking_settle_item.dart';
import '../../domain/use_cases/get_unresolved_bookings_use_case.dart';
import '../../domain/use_cases/settle_bookings_use_case.dart';
import 'unresolved_bookings_state.dart';

class UnresolvedBookingsCubit extends Cubit<UnresolvedBookingsState> {
  static const int pageSize = 10;

  final GetUnresolvedBookingsUseCase _getUnresolved;
  final SettleBookingsUseCase _settleBookings;

  UnresolvedBookingsCubit(this._getUnresolved, this._settleBookings)
    : super(const UnresolvedBookingsState());

  Future<void> load() async {
    emit(state.copyWith(status: UnresolvedBookingsStatus.loading));
    final result = await _getUnresolved(page: 0, size: pageSize);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: UnresolvedBookingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (unresolvedPage) => emit(
        state.copyWith(
          status: UnresolvedBookingsStatus.success,
          bookings: unresolvedPage.content,
          page: unresolvedPage.page,
          hasMore: unresolvedPage.hasMore,
          decisions: const {},
          reasons: const {},
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == UnresolvedBookingsStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: UnresolvedBookingsStatus.loadingMore));
    final result = await _getUnresolved(page: state.page + 1, size: pageSize);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: UnresolvedBookingsStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (unresolvedPage) => emit(
        state.copyWith(
          status: UnresolvedBookingsStatus.success,
          bookings: [...state.bookings, ...unresolvedPage.content],
          page: unresolvedPage.page,
          hasMore: unresolvedPage.hasMore,
        ),
      ),
    );
  }

  void setDecision(int bookingId, BookingSettleDecision? decision) {
    final decisions = {...state.decisions};
    if (decision == null) {
      decisions.remove(bookingId);
    } else {
      decisions[bookingId] = decision;
    }
    emit(state.copyWith(decisions: decisions));
  }

  void setReason(int bookingId, String reason) {
    emit(state.copyWith(reasons: {...state.reasons, bookingId: reason}));
  }

  Future<bool> submit() async {
    final items = state.decisions.entries
        .map(
          (entry) => BookingSettleItem(
            bookingId: entry.key,
            decision: entry.value,
            reason: state.reasons[entry.key],
          ),
        )
        .toList();

    if (items.isEmpty) return false;

    emit(state.copyWith(submitting: true, errorMessage: null));
    final result = await _settleBookings(items);

    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(submitting: false));
        return true;
      },
    );
  }
}
