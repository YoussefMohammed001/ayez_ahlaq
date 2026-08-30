class OrderItem {
  final String productName;
  final int qty;
  final int price;

  const OrderItem({required this.productName, required this.qty, required this.price});
}

enum OrderStatus { processing, shipped, delivered }

extension OrderStatusLabel on OrderStatus {
  String get label => switch (this) {
        OrderStatus.processing => 'جاري التجهيز',
        OrderStatus.shipped => 'في الطريق',
        OrderStatus.delivered => 'اتسلم',
      };

  OrderStatus? get next => switch (this) {
        OrderStatus.processing => OrderStatus.shipped,
        OrderStatus.shipped => OrderStatus.delivered,
        OrderStatus.delivered => null,
      };
}

/// An order placed by a barbershop (never a regular customer — this app's
/// entire catalog is wholesale/B2B) for this merchant's products.
class PurchaseOrder {
  final String code;
  final String shopName;
  final String barberName;
  final List<OrderItem> items;
  final int total;
  final String dateLabel;
  OrderStatus status;

  PurchaseOrder({
    required this.code,
    required this.shopName,
    required this.barberName,
    required this.items,
    required this.total,
    required this.dateLabel,
    required this.status,
  });
}
