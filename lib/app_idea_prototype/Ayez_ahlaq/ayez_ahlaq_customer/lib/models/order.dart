class OrderItem {
  final String name;
  final int qty;
  final int price;

  const OrderItem({required this.name, required this.qty, required this.price});
}

enum OrderStatus { processing, shipped, delivered }

class ProductOrder {
  final String code;
  final List<OrderItem> items;
  final int total;
  final String dateLabel;
  final OrderStatus status;

  const ProductOrder({
    required this.code,
    required this.items,
    required this.total,
    required this.dateLabel,
    required this.status,
  });
}
