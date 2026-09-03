import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';

enum BookingsStatus { initial, loading, success, failure }

class BookingsState extends Equatable {
  final BookingsStatus pendingStatus;
  final BookingsStatus queueStatus;
  final List<Booking> pending;
  final List<Booking> queue;
  final String? errorMessage;
  final int? updatingBookingId;
  final bool isSubmittingWalkIn;

  const BookingsState({
    this.pendingStatus = BookingsStatus.initial,
    this.queueStatus = BookingsStatus.initial,
    this.pending = const [],
    this.queue = const [],
    this.errorMessage,
    this.updatingBookingId,
    this.isSubmittingWalkIn = false,
  });

  BookingsState copyWith({
    BookingsStatus? pendingStatus,
    BookingsStatus? queueStatus,
    List<Booking>? pending,
    List<Booking>? queue,
    String? errorMessage,
    int? updatingBookingId,
    bool clearUpdatingBookingId = false,
    bool? isSubmittingWalkIn,
  }) {
    return BookingsState(
      pendingStatus: pendingStatus ?? this.pendingStatus,
      queueStatus: queueStatus ?? this.queueStatus,
      pending: pending ?? this.pending,
      queue: queue ?? this.queue,
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
    pending,
    queue,
    errorMessage,
    updatingBookingId,
    isSubmittingWalkIn,
  ];
}
