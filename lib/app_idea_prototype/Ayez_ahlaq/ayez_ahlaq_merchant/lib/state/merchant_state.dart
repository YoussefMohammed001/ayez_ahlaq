import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/product.dart';
import '../models/purchase_order.dart';

/// Single source of truth for the merchant app. This app is strictly
/// B2B — every buyer is a registered barber/shop account, never a walk-in
/// customer — so there's no customer-facing storefront here, only a
/// catalog to manage and incoming shop orders to fulfill.
class MerchantState extends ChangeNotifier {
  MerchantState() {
    products = MockData.buildProducts();
    orders = [
      PurchaseOrder(
        code: '#PO-2201',
        shopName: 'صالون الملك',
        barberName: 'محمد سعيد',
        items: const [
          OrderItem(productName: 'وكس تشكيل الشعر - تثبيت قوي', qty: 12, price: 120),
          OrderItem(productName: 'كريم حلاقة بالصبار', qty: 24, price: 60),
        ],
        total: 2880,
        dateLabel: 'النهاردة',
        status: OrderStatus.processing,
      ),
      PurchaseOrder(
        code: '#PO-2198',
        shopName: 'صالون الأصالة',
        barberName: 'أحمد ناصر',
        items: const [
          OrderItem(productName: 'زيت لحية طبيعي', qty: 18, price: 85),
        ],
        total: 1530,
        dateLabel: 'أمبارح',
        status: OrderStatus.shipped,
      ),
      PurchaseOrder(
        code: '#PO-2170',
        shopName: 'Barber House',
        barberName: 'كريم عادل',
        items: const [
          OrderItem(productName: 'ماكينة حلاقة كهربائية احترافية', qty: 3, price: 650),
          OrderItem(productName: 'مقص تشذيب دقيق', qty: 5, price: 180),
        ],
        total: 2850,
        dateLabel: 'قبل 4 أيام',
        status: OrderStatus.delivered,
      ),
    ];
  }

  // ----- catalog -----
  late List<Product> products;

  void addProduct({
    required String name,
    required String category,
    required int price,
    required String description,
    required int stock,
    required int minOrderQty,
  }) {
    products.insert(
      0,
      Product(
        id: 'p-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        category: category,
        price: price,
        rating: 5.0,
        gradient: const [Color(0xFF8F6C1F), Color(0xFF3A331F)],
        description: description,
        stock: stock,
        minOrderQty: minOrderQty,
      ),
    );
    notifyListeners();
  }

  void toggleProductActive(int index) {
    final p = products[index];
    products[index] = Product(
      id: p.id,
      name: p.name,
      category: p.category,
      price: p.price,
      rating: p.rating,
      gradient: p.gradient,
      description: p.description,
      stock: p.stock,
      minOrderQty: p.minOrderQty,
      active: !p.active,
    );
    notifyListeners();
  }

  void removeProduct(String id) {
    products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  // ----- orders from barbershops -----
  late List<PurchaseOrder> orders;

  void advanceOrderStatus(PurchaseOrder order) {
    final next = order.status.next;
    if (next != null) {
      order.status = next;
      notifyListeners();
    }
  }

  // ----- dashboard stats -----
  int get pendingOrdersCount => orders.where((o) => o.status != OrderStatus.delivered).length;

  int get revenueThisMonth => orders.fold(0, (sum, o) => sum + o.total);

  Product? get topProduct {
    if (products.isEmpty) return null;
    final counts = <String, int>{};
    for (final o in orders) {
      for (final item in o.items) {
        counts[item.productName] = (counts[item.productName] ?? 0) + item.qty;
      }
    }
    if (counts.isEmpty) return products.first;
    final topName = counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    return products.firstWhere((p) => p.name == topName, orElse: () => products.first);
  }
}
