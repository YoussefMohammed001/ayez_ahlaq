import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_booking.dart';

enum MyBookingsStatus { initial, loading, success, failure }

class MyBookingsState extends Equatable {
  final MyBookingsStatus status;
  final List<CustomerBooking> bookings;
  final String? errorMessage;

  const MyBookingsState({
    this.status = MyBookingsStatus.initial,
    this.bookings = const [],
    this.errorMessage,
  });

  List<CustomerBooking> get upcoming => bookings.where((b) => !b.status.isPast).toList();

  List<CustomerBooking> get past => bookings.where((b) => b.status.isPast).toList();

  MyBookingsState copyWith({
    MyBookingsStatus? status,
    List<CustomerBooking>? bookings,
    String? errorMessage,
  }) {
    return MyBookingsState(
      status: status ?? this.status,
      bookings: bookings ?? this.bookings,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, bookings, errorMessage];
}
