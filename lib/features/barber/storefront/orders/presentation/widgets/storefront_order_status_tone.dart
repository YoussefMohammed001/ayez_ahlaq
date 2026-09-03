import '../../../../../../core/widgets/badge_tone.dart';
import '../../domain/entities/storefront_order_status.dart';

extension StorefrontOrderStatusTone on StorefrontOrderStatus {
  BadgeTone get tone => switch (this) {
    StorefrontOrderStatus.pending => BadgeTone.gold,
    StorefrontOrderStatus.accepted => BadgeTone.open,
    StorefrontOrderStatus.preparing => BadgeTone.gold,
    StorefrontOrderStatus.readyForPickup => BadgeTone.info,
    StorefrontOrderStatus.outForDelivery => BadgeTone.info,
    StorefrontOrderStatus.delivered => BadgeTone.muted,
    StorefrontOrderStatus.rejected => BadgeTone.danger,
    StorefrontOrderStatus.cancelled => BadgeTone.danger,
  };
}
