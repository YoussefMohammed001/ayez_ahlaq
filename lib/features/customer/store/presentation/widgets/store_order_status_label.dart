import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_order_status.dart';

extension StoreOrderStatusLabel on StoreOrderStatus {
  String get label => switch (this) {
    StoreOrderStatus.pending => S().statusPending,
    StoreOrderStatus.accepted => S().statusAccepted,
    StoreOrderStatus.preparing => S().statusPreparing,
    StoreOrderStatus.readyForPickup => S().statusReadyForPickup,
    StoreOrderStatus.outForDelivery => S().statusOutForDelivery,
    StoreOrderStatus.delivered => S().statusDelivered,
    StoreOrderStatus.rejected => S().statusRejected,
    StoreOrderStatus.cancelled => S().statusCancelled,
  };
}
