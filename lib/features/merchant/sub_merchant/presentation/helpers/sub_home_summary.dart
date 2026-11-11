import '../../../../../generated/l10n.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../../../orders/domain/entities/purchase_order.dart';
import '../../../products/domain/entities/merchant_product.dart';
import '../../../sales/domain/entities/sale.dart';

class SubHomeSummary {
  const SubHomeSummary._();

  static ({int pending, int active}) ordersOf(List<PurchaseOrder> orders) {
    var pending = 0;
    var active = 0;

    for (final order in orders) {
      if (order.status.needsDecision) {
        pending++;
      } else if (!order.status.isTerminal) {
        active++;
      }
    }

    return (pending: pending, active: active);
  }

  static List<PurchaseOrder> latestOrdersOf(
    List<PurchaseOrder> orders,
    int count,
  ) {
    final sorted = [...orders]
      ..sort((a, b) {
        final first = a.createdAt;
        final second = b.createdAt;
        if (first == null && second == null) return b.id.compareTo(a.id);
        if (first == null) return 1;
        if (second == null) return -1;
        return second.compareTo(first);
      });
    return sorted.take(count).toList();
  }

  static bool isScheduleSet(List<WorkingDay> days) =>
      days.any((day) => day.isOpen);

  static List<MerchantProduct> lowStockOf(List<MerchantProduct> products) {
    return products
        .where(
          (p) => p.active && p.totalStock <= MerchantProduct.lowStockThreshold,
        )
        .toList()
      ..sort((a, b) => a.totalStock.compareTo(b.totalStock));
  }

  static ({int count, double total}) salesTodayOf(
    List<Sale> sales,
    DateTime now,
  ) {
    var count = 0;
    var total = 0.0;

    for (final sale in sales) {
      final created = sale.createdAt;
      if (sale.isCancelled || created == null) continue;
      if (created.year == now.year &&
          created.month == now.month &&
          created.day == now.day) {
        count++;
        total += sale.total;
      }
    }

    return (count: count, total: total);
  }

  static String todayHoursLabel(List<WorkingDay> days, DateTime now) {
    final today = now.weekday % DateTime.daysPerWeek;

    for (final day in days) {
      if (day.dayOfWeek % DateTime.daysPerWeek != today) continue;
      if (!day.isOpen) return S().scheduleDayOff;
      return S().scheduleTimeRange(_clock(day.openTime), _clock(day.closeTime));
    }

    return '';
  }

  static String _clock(String time) =>
      time.length >= 5 ? time.substring(0, 5) : time;
}
