import 'package:equatable/equatable.dart';
import 'booking_settle_decision.dart';

class BookingSettleItem extends Equatable {
  final int bookingId;
  final BookingSettleDecision decision;
  final String? reason;

  const BookingSettleItem({
    required this.bookingId,
    required this.decision,
    this.reason,
  });

  Map<String, dynamic> toJson() => {
    'bookingId': bookingId,
    'decision': decision.toApi(),
    if (reason != null) 'reason': reason,
  };

  @override
  List<Object?> get props => [bookingId, decision, reason];
}
