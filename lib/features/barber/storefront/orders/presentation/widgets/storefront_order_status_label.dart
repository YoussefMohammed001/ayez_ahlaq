import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order_status.dart';

extension StorefrontOrderStatusLabel on StorefrontOrderStatus {
  String get label => switch (this) {
    StorefrontOrderStatus.pending => S().statusPending,
    StorefrontOrderStatus.accepted => S().statusAccepted,
    StorefrontOrderStatus.preparing => S().statusPreparing,
    StorefrontOrderStatus.readyForPickup => S().statusReadyForPickup,
    StorefrontOrderStatus.outForDelivery => S().statusOutForDelivery,
    StorefrontOrderStatus.delivered => S().statusDelivered,
    StorefrontOrderStatus.rejected => S().statusRejected,
    StorefrontOrderStatus.cancelled => S().statusCancelled,
  };
}
