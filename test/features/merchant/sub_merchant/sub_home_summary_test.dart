import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/fulfilment_type.dart';
import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/order_status.dart';
import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/purchase_order.dart';
import 'package:ayez_ahlaq/features/merchant/products/domain/entities/merchant_product.dart';
import 'package:ayez_ahlaq/features/merchant/products/domain/entities/product_image_source.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/entities/sale.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/entities/sale_status.dart';
import 'package:ayez_ahlaq/features/merchant/sub_merchant/presentation/helpers/sub_home_summary.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

PurchaseOrder _order(int id, OrderStatus status, {DateTime? createdAt}) =>
    PurchaseOrder(
      id: id,
      code: 'PO-$id',
      shopName: 'shop',
      barberName: 'barber',
      items: const [],
      subtotal: 100,
      orderDiscount: 0,
      total: 100,
      status: status,
      fulfilmentType: FulfilmentType.pickupAtBranch,
      nextStatuses: const [],
      deliveryFee: 0,
      grandTotal: 100,
      createdAt: createdAt,
    );

MerchantProduct _product(int id, int stock, {bool active = true}) =>
    MerchantProduct(
      id: id,
      name: 'p$id',
      price: 10,
      effectivePrice: 10,
      minOrderQty: 1,
      active: active,
      totalStock: stock,
      imageSource: ProductImageSource.none,
      imageIds: const [],
    );

Sale _sale(
  int id,
  DateTime? createdAt,
  double total, {
  SaleStatus status = SaleStatus.done,
}) => Sale(
  id: id,
  code: 'MS-$id',
  subtotal: total,
  discount: 0,
  total: total,
  status: status,
  items: const [],
  createdAt: createdAt,
);

void main() {
  group('orders', () {
    test('pending needs an answer, the rest of the open ones are active', () {
      final summary = SubHomeSummary.ordersOf([
        _order(1, OrderStatus.pending),
        _order(2, OrderStatus.pending),
        _order(3, OrderStatus.accepted),
        _order(4, OrderStatus.preparing),
        _order(5, OrderStatus.outForDelivery),
        _order(6, OrderStatus.delivered),
        _order(7, OrderStatus.rejected),
        _order(8, OrderStatus.cancelled),
      ]);

      expect(summary.pending, 2);
      expect(summary.active, 3);
    });

    test('no orders gives zeros', () {
      final summary = SubHomeSummary.ordersOf(const []);

      expect(summary.pending, 0);
      expect(summary.active, 0);
    });
  });

  group('latest orders', () {
    test('newest first, limited, and orders without a date go last', () {
      final latest = SubHomeSummary.latestOrdersOf([
        _order(1, OrderStatus.pending, createdAt: DateTime(2026, 11, 9)),
        _order(2, OrderStatus.pending),
        _order(3, OrderStatus.delivered, createdAt: DateTime(2026, 11, 11)),
        _order(4, OrderStatus.pending, createdAt: DateTime(2026, 11, 10)),
        _order(5, OrderStatus.pending),
      ], 4);

      expect(latest.map((o) => o.id), [3, 4, 1, 5]);
    });

    test('does not change the list it was given and handles fewer orders', () {
      final orders = [_order(1, OrderStatus.pending)];

      expect(SubHomeSummary.latestOrdersOf(orders, 3).length, 1);
      expect(SubHomeSummary.latestOrdersOf(const [], 3), isEmpty);
      expect(orders.length, 1);
    });
  });

  group('low stock', () {
    test('keeps active products at or under the threshold, lowest first', () {
      final low = SubHomeSummary.lowStockOf([
        _product(1, 20),
        _product(2, 5),
        _product(3, 0),
        _product(4, 2),
        _product(5, 1, active: false),
        _product(6, 6),
      ]);

      expect(low.map((p) => p.id), [3, 4, 2]);
    });

    test('nothing running out gives an empty list', () {
      expect(SubHomeSummary.lowStockOf([_product(1, 50)]), isEmpty);
    });
  });

  group('sales today', () {
    final now = DateTime(2026, 11, 11, 15, 30);

    test('counts and sums only completed sales of today', () {
      final today = SubHomeSummary.salesTodayOf([
        _sale(1, DateTime(2026, 11, 11, 9), 120),
        _sale(2, DateTime(2026, 11, 11, 23, 59), 40.5),
        _sale(3, DateTime(2026, 11, 10, 23, 59), 999),
        _sale(4, DateTime(2026, 11, 11, 10), 500, status: SaleStatus.cancelled),
        _sale(5, null, 77),
        _sale(6, DateTime(2025, 11, 11, 10), 88),
      ], now);

      expect(today.count, 2);
      expect(today.total, 160.5);
    });

    test('no sales today', () {
      final today = SubHomeSummary.salesTodayOf(const [], now);

      expect(today.count, 0);
      expect(today.total, 0);
    });
  });

  group('schedule is set', () {
    test('false when every day is off or there are no days', () {
      expect(SubHomeSummary.isScheduleSet(const []), isFalse);
      expect(
        SubHomeSummary.isScheduleSet([
          for (var day = 0; day < 7; day++) WorkingDay.closed(day),
        ]),
        isFalse,
      );
    });

    test('true as soon as one day has hours', () {
      expect(
        SubHomeSummary.isScheduleSet([
          const WorkingDay.closed(0),
          const WorkingDay(
            dayOfWeek: 1,
            isOpen: true,
            openTime: '09:00:00',
            closeTime: '17:00:00',
          ),
        ]),
        isTrue,
      );
    });
  });

  group('today hours', () {
    final wednesday = DateTime(2026, 11, 11, 12);
    final sunday = DateTime(2026, 11, 8, 12);
    final days = [
      const WorkingDay(
        dayOfWeek: 0,
        isOpen: true,
        openTime: '09:00:00',
        closeTime: '17:00:00',
      ),
      const WorkingDay.closed(3),
      const WorkingDay(
        dayOfWeek: 6,
        isOpen: true,
        openTime: '22:00:00',
        closeTime: '02:00:00',
      ),
    ];

    test('shows the range without seconds on a working day', () {
      expect(
        SubHomeSummary.todayHoursLabel(days, sunday),
        S().scheduleTimeRange('09:00', '17:00'),
      );
    });

    test('shows a day off', () {
      expect(
        SubHomeSummary.todayHoursLabel(days, wednesday),
        S().scheduleDayOff,
      );
    });

    test('an overnight shift keeps both ends', () {
      final saturday = DateTime(2026, 11, 14, 12);

      expect(
        SubHomeSummary.todayHoursLabel(days, saturday),
        S().scheduleTimeRange('22:00', '02:00'),
      );
    });

    test('a day missing from the schedule gives an empty label', () {
      expect(SubHomeSummary.todayHoursLabel(days, DateTime(2026, 11, 9)), '');
      expect(SubHomeSummary.todayHoursLabel(const [], wednesday), '');
    });
  });
}
