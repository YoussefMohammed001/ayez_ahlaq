import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking_status.dart';

extension BookingStatusLabel on BookingStatus {
  String get label => switch (this) {
    BookingStatus.pending => S().bookingStatusPending,
    BookingStatus.confirmed => S().bookingStatusConfirmed,
    BookingStatus.upcoming => S().bookingStatusUpcoming,
    BookingStatus.next => S().bookingStatusNext,
    BookingStatus.active => S().bookingStatusActive,
    BookingStatus.done => S().bookingStatusDone,
    BookingStatus.noShow => S().bookingStatusNoShow,
    BookingStatus.rejected => S().bookingStatusRejected,
    BookingStatus.cancelled => S().bookingStatusCancelled,
  };
}
