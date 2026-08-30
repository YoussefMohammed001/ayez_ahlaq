import '../../../../../core/widgets/badge_tone.dart';
import '../../domain/entities/order_status.dart';

extension OrderStatusTone on OrderStatus {
  BadgeTone get tone => switch (this) {
    OrderStatus.pending => BadgeTone.gold,
    OrderStatus.accepted => BadgeTone.open,
    OrderStatus.preparing => BadgeTone.gold,
    OrderStatus.readyForPickup => BadgeTone.info,
    OrderStatus.outForDelivery => BadgeTone.info,
    OrderStatus.delivered => BadgeTone.muted,
    OrderStatus.rejected => BadgeTone.danger,
    OrderStatus.cancelled => BadgeTone.danger,
  };
}
