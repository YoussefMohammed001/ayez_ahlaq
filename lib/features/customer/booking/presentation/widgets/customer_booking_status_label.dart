import '../../../../../generated/l10n.dart';
import '../../domain/entities/customer_booking_status.dart';

extension CustomerBookingStatusLabel on CustomerBookingStatus {
  String get label => switch (this) {
    CustomerBookingStatus.pending => S().bookingStatusPending,
    CustomerBookingStatus.confirmed => S().bookingStatusConfirmed,
    CustomerBookingStatus.upcoming => S().bookingStatusUpcoming,
    CustomerBookingStatus.next => S().bookingStatusNext,
    CustomerBookingStatus.active => S().bookingStatusActive,
    CustomerBookingStatus.done => S().bookingStatusDone,
    CustomerBookingStatus.noShow => S().bookingStatusNoShow,
    CustomerBookingStatus.rejected => S().bookingStatusRejected,
    CustomerBookingStatus.cancelled => S().bookingStatusCancelled,
  };
}
