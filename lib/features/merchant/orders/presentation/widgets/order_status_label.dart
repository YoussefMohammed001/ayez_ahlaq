import '../../../../../generated/l10n.dart';
import '../../domain/entities/order_status.dart';

extension OrderStatusLabel on OrderStatus {
  String get label => switch (this) {
    OrderStatus.pending => S().statusPending,
    OrderStatus.accepted => S().statusAccepted,
    OrderStatus.preparing => S().statusPreparing,
    OrderStatus.readyForPickup => S().statusReadyForPickup,
    OrderStatus.outForDelivery => S().statusOutForDelivery,
    OrderStatus.delivered => S().statusDelivered,
    OrderStatus.rejected => S().statusRejected,
    OrderStatus.cancelled => S().statusCancelled,
  };
}
