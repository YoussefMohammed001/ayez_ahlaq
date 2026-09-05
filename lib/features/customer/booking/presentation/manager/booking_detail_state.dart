import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_booking.dart';

enum BookingDetailStatus { initial, loading, success, failure }

class BookingDetailState extends Equatable {
  final BookingDetailStatus status;
  final CustomerBooking? booking;
  final bool isCancelling;
  final bool isRating;
  final String? errorMessage;

  const BookingDetailState({
    this.status = BookingDetailStatus.initial,
    this.booking,
    this.isCancelling = false,
    this.isRating = false,
    this.errorMessage,
  });

  BookingDetailState copyWith({
    BookingDetailStatus? status,
    CustomerBooking? booking,
    bool? isCancelling,
    bool? isRating,
    String? errorMessage,
  }) {
    return BookingDetailState(
      status: status ?? this.status,
      booking: booking ?? this.booking,
      isCancelling: isCancelling ?? this.isCancelling,
      isRating: isRating ?? this.isRating,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, booking, isCancelling, isRating, errorMessage];
}
