import 'order_status.dart';
import 'purchase_order.dart';

extension OrderInsights on List<PurchaseOrder> {
  Map<OrderStatus, int> get countByStatus {
    final counts = <OrderStatus, int>{};
    for (final order in this) {
      counts[order.status] = (counts[order.status] ?? 0) + 1;
    }
    return counts;
  }

  List<OrderStatus> get presentStatuses {
    final counts = countByStatus;
    return OrderStatus.values
        .where((status) => counts.containsKey(status))
        .toList();
  }
}
