import '../../../../../core/widgets/badge_tone.dart';
import '../../domain/entities/customer_booking_status.dart';

extension CustomerBookingStatusTone on CustomerBookingStatus {
  BadgeTone get tone => switch (this) {
    CustomerBookingStatus.pending => BadgeTone.gold,
    CustomerBookingStatus.confirmed => BadgeTone.open,
    CustomerBookingStatus.upcoming => BadgeTone.info,
    CustomerBookingStatus.next => BadgeTone.info,
    CustomerBookingStatus.active => BadgeTone.gold,
    CustomerBookingStatus.done => BadgeTone.muted,
    CustomerBookingStatus.noShow => BadgeTone.danger,
    CustomerBookingStatus.rejected => BadgeTone.danger,
    CustomerBookingStatus.cancelled => BadgeTone.danger,
  };
}
