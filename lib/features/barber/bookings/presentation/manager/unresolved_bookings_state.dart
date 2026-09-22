import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_settle_decision.dart';

enum UnresolvedBookingsStatus { initial, loading, loadingMore, success, failure }

class UnresolvedBookingsState extends Equatable {
  final UnresolvedBookingsStatus status;
  final List<Booking> bookings;
  final int page;
  final bool hasMore;
  final Map<int, BookingSettleDecision> decisions;
  final Map<int, String> reasons;
  final bool submitting;
  final String? errorMessage;

  const UnresolvedBookingsState({
    this.status = UnresolvedBookingsStatus.initial,
    this.bookings = const [],
    this.page = 0,
    this.hasMore = false,
    this.decisions = const {},
    this.reasons = const {},
    this.submitting = false,
    this.errorMessage,
  });

  bool get hasDecisions => decisions.isNotEmpty;

  UnresolvedBookingsState copyWith({
    UnresolvedBookingsStatus? status,
    List<Booking>? bookings,
    int? page,
    bool? hasMore,
    Map<int, BookingSettleDecision>? decisions,
    Map<int, String>? reasons,
    bool? submitting,
    String? errorMessage,
  }) {
    return UnresolvedBookingsState(
      status: status ?? this.status,
      bookings: bookings ?? this.bookings,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      decisions: decisions ?? this.decisions,
      reasons: reasons ?? this.reasons,
      submitting: submitting ?? this.submitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    bookings,
    page,
    hasMore,
    decisions,
    reasons,
    submitting,
    errorMessage,
  ];
}
