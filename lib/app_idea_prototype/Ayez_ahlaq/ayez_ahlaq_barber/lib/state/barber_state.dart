import 'dart:math';
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/queue_entry.dart';
import '../models/week_day.dart';
import '../models/shop_service.dart';
import '../models/order.dart';
import '../models/product.dart';

enum PaymentMethod { cash, card }

/// Single source of truth for the barber-facing app: today's queue,
/// weekly schedule, service menu, and the shared supplies-store cart.
class BarberState extends ChangeNotifier {
  BarberState() {
    week = MockData.buildWeek();
    services = MockData.buildServices();
    queueToday = [
      QueueEntry(time: '11:00', customerName: 'كريم فتحي', barberName: 'محمد سعيد', service: 'قصة شعر عادية', price: 100, durationMinutes: 30, status: QueueStatus.done, phone: '01098765432'),
      QueueEntry(time: '11:30', customerName: 'يوسف عادل', barberName: 'محمد سعيد', service: 'حلاقة ذقن فقط', price: 70, durationMinutes: 20, status: QueueStatus.done, phone: '01123456789'),
      QueueEntry(time: '12:00', customerName: 'عمر شريف', barberName: 'محمد سعيد', service: 'قصة + صبغة', price: 280, durationMinutes: 75, status: QueueStatus.active, phone: '01099887766', note: 'حاب الصبغة درجة فاتحة شوية'),
      QueueEntry(time: '12:30', customerName: 'مختار توفيق', barberName: 'محمد سعيد', service: 'قصة + تهذيب ذقن', price: 150, durationMinutes: 45, status: QueueStatus.next, phone: '01012345678'),
      QueueEntry(time: '1:30', customerName: 'أحمد سامي', barberName: 'محمد سعيد', service: 'قصة شعر عادية', price: 100, durationMinutes: 30, status: QueueStatus.upcoming, phone: '01055443322'),
      QueueEntry(time: '2:00', customerName: 'زياد حسن', barberName: 'محمد سعيد', service: 'قصة أطفال', price: 80, durationMinutes: 25, status: QueueStatus.upcoming, phone: '01077889900'),
    ];
    orders = [
      const ProductOrder(
        code: '#ORD-1042',
        items: [
          OrderItem(name: 'وكس تشكيل الشعر - تثبيت قوي', qty: 3, price: 120),
          OrderItem(name: 'كريم حلاقة بالصبار', qty: 5, price: 60),
        ],
        total: 660,
        dateLabel: '2 أغسطس',
        status: OrderStatus.delivered,
      ),
    ];
  }

  // ----- availability -----
  bool available = true;
  void toggleAvailable() {
    available = !available;
    notifyListeners();
  }

  // ----- queue -----
  late List<QueueEntry> queueToday;

  int get totalToday => queueToday.length;
  int get doneToday => queueToday.where((q) => q.status == QueueStatus.done).length;
  int get expectedEarnings => queueToday
      .where((q) => q.status == QueueStatus.done || q.status == QueueStatus.active)
      .fold(0, (sum, q) => sum + q.price);

  void startService(int index) {
    final current = queueToday.where((q) => q.status == QueueStatus.active);
    for (final q in current) {
      q.status = QueueStatus.done;
    }
    queueToday[index].status = QueueStatus.active;
    notifyListeners();
  }

  void finishService(int index) {
    queueToday[index].status = QueueStatus.done;
    final hasNext = queueToday.any((q) => q.status == QueueStatus.next);
    if (!hasNext) {
      final upcoming = queueToday.where((q) => q.status == QueueStatus.upcoming);
      if (upcoming.isNotEmpty) upcoming.first.status = QueueStatus.next;
    }
    notifyListeners();
  }

  void cancelBooking(int index) {
    queueToday[index].status = QueueStatus.cancelled;
    notifyListeners();
  }

  /// Registers a walk-in — someone who showed up off the street rather
  /// than booking through the app — so today's queue (and, in a real
  /// backend, the availability customers see) reflects that slot being
  /// taken. Available from both the phone app and the desktop app.
  void addWalkIn({
    required String customerName,
    required String barberName,
    required String service,
    required int price,
    required int durationMinutes,
    required String time,
    required QueueStatus status,
  }) {
    queueToday.add(QueueEntry(
      time: time,
      customerName: customerName.trim().isEmpty ? 'عميل من غير اسم' : customerName.trim(),
      barberName: barberName,
      service: service,
      price: price,
      durationMinutes: durationMinutes,
      status: status,
      walkIn: true,
    ));
    notifyListeners();
  }

  // ----- schedule -----
  late List<WeekDay> week;
  void toggleDay(int index) {
    week[index].isOff = !week[index].isOff;
    notifyListeners();
  }

  // ----- services -----
  late List<ShopService> services;
  void toggleServiceActive(int index) {
    services[index].active = !services[index].active;
    notifyListeners();
  }

  // ----- store / cart (shared shape with the customer app) -----
  final Map<String, int> cart = {};

  int get cartCount => cart.values.fold(0, (a, b) => a + b);

  int get cartTotal {
    return cart.entries.fold(0, (sum, entry) {
      final product = MockData.products.firstWhere((p) => p.id == entry.key);
      return sum + product.price * entry.value;
    });
  }

  void addToCart(String productId, {int qty = 1}) {
    cart[productId] = (cart[productId] ?? 0) + qty;
    notifyListeners();
  }

  void changeCartQty(String productId, int delta) {
    final next = (cart[productId] ?? 0) + delta;
    if (next <= 0) {
      cart.remove(productId);
    } else {
      cart[productId] = next;
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    cart.remove(productId);
    notifyListeners();
  }

  PaymentMethod storePayment = PaymentMethod.cash;
  void setStorePayment(PaymentMethod method) {
    storePayment = method;
    notifyListeners();
  }

  int get deliveryFee => cartTotal >= 300 || cartTotal == 0 ? 0 : 30;
  int get checkoutTotal => cartTotal + deliveryFee;

  late List<ProductOrder> orders;

  ProductOrder confirmOrder() {
    final code = '#ORD-${1100 + Random().nextInt(899)}';
    final items = cart.entries.map((entry) {
      final product = MockData.products.firstWhere((p) => p.id == entry.key);
      return OrderItem(name: product.name, qty: entry.value, price: product.price);
    }).toList();
    final order = ProductOrder(code: code, items: items, total: checkoutTotal, dateLabel: 'النهاردة', status: OrderStatus.processing);
    orders.insert(0, order);
    cart.clear();
    notifyListeners();
    return order;
  }

  String selectedCategory = 'الكل';
  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    if (selectedCategory == 'الكل') return MockData.products;
    return MockData.products.where((p) => p.category == selectedCategory).toList();
  }

  // ----- the barber's own products (his personal storefront) -----
  // Most barbers already sell their own pomade/oil/kits on the side, so
  // this lets him list those separately from the platform's shared
  // supplies catalog above.
  final List<Product> myProducts = [];

  void addMyProduct({
    required String name,
    required String category,
    required int price,
    required String description,
  }) {
    myProducts.insert(
      0,
      Product(
        id: 'mine-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        category: category,
        price: price,
        rating: 5.0,
        gradient: const [Color(0xFF8F6C1F), Color(0xFF3A331F)],
        description: description,
      ),
    );
    notifyListeners();
  }

  void removeMyProduct(String productId) {
    myProducts.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
