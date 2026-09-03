import '../../../../../core/widgets/badge_tone.dart';
import '../../domain/entities/booking_status.dart';

extension BookingStatusTone on BookingStatus {
  BadgeTone get tone => switch (this) {
    BookingStatus.pending => BadgeTone.gold,
    BookingStatus.confirmed => BadgeTone.open,
    BookingStatus.upcoming => BadgeTone.info,
    BookingStatus.next => BadgeTone.info,
    BookingStatus.active => BadgeTone.gold,
    BookingStatus.done => BadgeTone.muted,
    BookingStatus.noShow => BadgeTone.danger,
    BookingStatus.rejected => BadgeTone.danger,
    BookingStatus.cancelled => BadgeTone.danger,
  };
}
