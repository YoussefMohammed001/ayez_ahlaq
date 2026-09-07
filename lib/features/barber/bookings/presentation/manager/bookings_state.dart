import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';

enum BookingsStatus { initial, loading, success, failure }

class BookingsState extends Equatable {
  final BookingsStatus pendingStatus;
  final BookingsStatus queueStatus;
  final BookingsStatus historyStatus;
  final List<Booking> pending;
  final List<Booking> queue;
  final List<Booking> history;
  final String? errorMessage;
  final int? updatingBookingId;
  final bool isSubmittingWalkIn;

  const BookingsState({
    this.pendingStatus = BookingsStatus.initial,
    this.queueStatus = BookingsStatus.initial,
    this.historyStatus = BookingsStatus.initial,
    this.pending = const [],
    this.queue = const [],
    this.history = const [],
    this.errorMessage,
    this.updatingBookingId,
    this.isSubmittingWalkIn = false,
  });

  BookingsState copyWith({
    BookingsStatus? pendingStatus,
    BookingsStatus? queueStatus,
    BookingsStatus? historyStatus,
    List<Booking>? pending,
    List<Booking>? queue,
    List<Booking>? history,
    String? errorMessage,
    int? updatingBookingId,
    bool clearUpdatingBookingId = false,
    bool? isSubmittingWalkIn,
  }) {
    return BookingsState(
      pendingStatus: pendingStatus ?? this.pendingStatus,
      queueStatus: queueStatus ?? this.queueStatus,
      historyStatus: historyStatus ?? this.historyStatus,
      pending: pending ?? this.pending,
      queue: queue ?? this.queue,
      history: history ?? this.history,
      errorMessage: errorMessage,
      updatingBookingId: clearUpdatingBookingId
          ? null
          : (updatingBookingId ?? this.updatingBookingId),
      isSubmittingWalkIn: isSubmittingWalkIn ?? this.isSubmittingWalkIn,
    );
  }

  @override
  List<Object?> get props => [
    pendingStatus,
    queueStatus,
    historyStatus,
    pending,
    queue,
    history,
    errorMessage,
    updatingBookingId,
    isSubmittingWalkIn,
  ];
}
