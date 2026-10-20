import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_adjustment.dart';
import '../../domain/entities/booking_drink.dart';
import '../../domain/entities/booking_status.dart';
import '../../domain/use_cases/advance_booking_status_use_case.dart';
import '../../domain/use_cases/confirm_booking_use_case.dart';
import '../../domain/use_cases/create_walk_in_use_case.dart';
import '../../domain/use_cases/get_booking_use_case.dart';
import '../../domain/use_cases/get_bookings_use_case.dart';
import '../../domain/use_cases/get_pending_bookings_use_case.dart';
import '../../domain/use_cases/get_queue_use_case.dart';
import '../../domain/use_cases/reject_booking_use_case.dart';
import '../../domain/use_cases/update_booking_billing_use_case.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  final GetPendingBookingsUseCase _getPending;
  final GetQueueUseCase _getQueue;
  final GetBookingsUseCase _getBookings;
  final GetBookingUseCase _getBooking;
  final ConfirmBookingUseCase _confirmBooking;
  final RejectBookingUseCase _rejectBooking;
  final AdvanceBookingStatusUseCase _advanceStatus;
  final CreateWalkInUseCase _createWalkIn;
  final UpdateBookingBillingUseCase _updateBilling;

  BookingsCubit(
    this._getPending,
    this._getQueue,
    this._getBookings,
    this._getBooking,
    this._confirmBooking,
    this._rejectBooking,
    this._advanceStatus,
    this._createWalkIn,
    this._updateBilling,
  ) : super(const BookingsState());

  Future<void> loadPending() async {
    emit(state.copyWith(pendingStatus: BookingsStatus.loading));

    final result = await _getPending();

    result.fold(
      (failure) => emit(
        state.copyWith(
          pendingStatus: BookingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (pending) => emit(
        state.copyWith(pendingStatus: BookingsStatus.success, pending: pending),
      ),
    );
  }

  Future<void> loadQueue() async {
    emit(state.copyWith(queueStatus: BookingsStatus.loading));

    final today = AppDateTime.formatDateForApi(DateTime.now());
    final result = await _getQueue(today);

    result.fold(
      (failure) => emit(
        state.copyWith(
          queueStatus: BookingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (queue) =>
          emit(state.copyWith(queueStatus: BookingsStatus.success, queue: queue)),
    );
  }

  Future<void> loadHistory() async {
    emit(state.copyWith(historyStatus: BookingsStatus.loading));

    final result = await _getBookings();

    result.fold(
      (failure) => emit(
        state.copyWith(
          historyStatus: BookingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (history) {
        final sorted = [...history]..sort(
          (a, b) => (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)),
        );
        emit(state.copyWith(historyStatus: BookingsStatus.success, history: sorted));
      },
    );
  }

  Future<Booking?> refreshBooking(int id) async {
    final result = await _getBooking(id);

    return result.fold((failure) => null, (booking) {
      emit(
        state.copyWith(
          pending: _replace(state.pending, booking),
          queue: _replace(state.queue, booking),
          history: _replace(state.history, booking),
        ),
      );
      return booking;
    });
  }

  Future<void> confirmBooking(int id) => _mutate(id, () => _confirmBooking(id));

  Future<void> rejectBooking(int id, String reason) =>
      _mutate(id, () => _rejectBooking(id, reason));

  Future<void> advanceStatus(int id, BookingStatus status) =>
      _mutate(id, () => _advanceStatus(id, status));

  Future<bool> createWalkIn({
    required int barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    String? customerName,
    String? customerPhone,
    String? slotTime,
    required String paymentMethod,
    String? note,
    List<BookingAddon> addons = const [],
    List<BookingDrink> drinks = const [],
  }) async {
    emit(state.copyWith(isSubmittingWalkIn: true));

    final result = await _createWalkIn(
      barberId: barberId,
      serviceTypeId: serviceTypeId,
      haircutStyleId: haircutStyleId,
      customerName: customerName,
      customerPhone: customerPhone,
      slotTime: slotTime,
      paymentMethod: paymentMethod,
      note: note,
      addons: addons,
      drinks: drinks,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSubmittingWalkIn: false,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (booking) {
        emit(
          state.copyWith(
            isSubmittingWalkIn: false,
            queue: [...state.queue, booking],
          ),
        );
        return true;
      },
    );
  }

  Future<bool> updateBilling({
    required int id,
    required List<BookingDrink> drinks,
    required List<BookingAddon> addons,
    required List<BookingAdjustment> adjustments,
  }) async {
    emit(state.copyWith(updatingBookingId: id));

    final result = await _updateBilling(
      id: id,
      drinks: drinks,
      addons: addons,
      adjustments: adjustments,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            clearUpdatingBookingId: true,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (booking) {
        emit(
          state.copyWith(
            clearUpdatingBookingId: true,
            pending: _replace(state.pending, booking),
            queue: _replace(state.queue, booking),
            history: _replace(state.history, booking),
          ),
        );
        return true;
      },
    );
  }

  Future<void> _mutate(int id, Future<dynamic> Function() action) async {
    emit(state.copyWith(updatingBookingId: id));

    final result = await action();

    result.fold(
      (failure) => emit(
        state.copyWith(
          clearUpdatingBookingId: true,
          errorMessage: failure.message,
        ),
      ),
      (booking) {
        final leftPending =
            state.pending.any((b) => b.id == booking.id) &&
            !booking.status.needsDecision;
        emit(
          state.copyWith(
            clearUpdatingBookingId: true,
            pending: leftPending
                ? state.pending.where((b) => b.id != booking.id).toList()
                : _replace(state.pending, booking),
            queue: _replace(state.queue, booking),
            history: _replace(state.history, booking),
          ),
        );
        if (leftPending) loadQueue();
      },
    );
  }

  List<Booking> _replace(List<Booking> bookings, Booking updated) {
    if (!bookings.any((booking) => booking.id == updated.id)) return bookings;
    return [
      for (final booking in bookings)
        if (booking.id == updated.id) updated else booking,
    ];
  }
}
