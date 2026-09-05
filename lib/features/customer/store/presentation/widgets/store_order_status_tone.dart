import '../../../../../core/widgets/badge_tone.dart';
import '../../domain/entities/store_order_status.dart';

extension StoreOrderStatusTone on StoreOrderStatus {
  BadgeTone get tone => switch (this) {
    StoreOrderStatus.pending => BadgeTone.gold,
    StoreOrderStatus.accepted => BadgeTone.open,
    StoreOrderStatus.preparing => BadgeTone.gold,
    StoreOrderStatus.readyForPickup => BadgeTone.info,
    StoreOrderStatus.outForDelivery => BadgeTone.info,
    StoreOrderStatus.delivered => BadgeTone.muted,
    StoreOrderStatus.rejected => BadgeTone.danger,
    StoreOrderStatus.cancelled => BadgeTone.danger,
  };
}
