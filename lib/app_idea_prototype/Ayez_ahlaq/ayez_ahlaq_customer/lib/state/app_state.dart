import 'dart:math';
import 'package:flutter/foundation.dart';
import '../data/mock_data.dart';
import '../models/shop.dart';
import '../models/barber.dart';
import '../models/service.dart';
import '../models/booking.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/haircut_style.dart';

enum PaymentMethod { cash, card }

/// Single source of truth for the whole customer app. Everything the
/// prototype needs to remember between screens lives here — the current
/// booking-flow selections, favorites, the cart, and order/booking history.
///
/// This mirrors a typical real backend 1:1 in shape, so swapping the mock
/// lists in [MockData] for API-backed repositories later is a drop-in
/// change — screens only ever talk to this class.
class AppState extends ChangeNotifier {
  AppState() {
    favoriteShopIds = {'hassan', 'malek'};
    bookings = [
      Booking(
        code: '#AH-4790',
        shop: MockData.allShops['asala']!,
        barber: MockData.barbers[2],
        service: MockData.services[0],
        styleName: MockData.haircutStyles[0].name,
        totalPrice: MockData.services[0].price,
        dateLabel: '15 يوليو',
        time: '11:00 ص',
        done: true,
      ),
    ];
    orders = [
      const ProductOrder(
        code: '#ORD-1042',
        items: [
          OrderItem(name: 'وكس تشكيل الشعر - تثبيت قوي', qty: 1, price: 120),
          OrderItem(name: 'زيت لحية طبيعي', qty: 1, price: 85),
        ],
        total: 205,
        dateLabel: '2 أغسطس',
        status: OrderStatus.delivered,
      ),
    ];
  }

  // ----- booking flow selection -----
  Shop selectedShop = MockData.allShops['malek']!;
  Barber selectedBarber = MockData.barbers[0];
  BarberService selectedService = MockData.services[1];
  HaircutStyle selectedStyle = MockData.haircutStyles[0];
  String selectedDateId = 'd1';
  String? selectedTime = '12:30';
  PaymentMethod bookingPayment = PaymentMethod.cash;

  /// Service price plus whatever the chosen named style adds (or shaves
  /// off, for a quick buzz cut).
  int get totalServicePrice => selectedService.price + selectedStyle.priceDelta;

  void selectShop(Shop shop) {
    selectedShop = shop;
    notifyListeners();
  }

  void selectBarber(Barber barber) {
    selectedBarber = barber;
    notifyListeners();
  }

  void selectService(BarberService service) {
    selectedService = service;
    notifyListeners();
  }

  void selectStyle(HaircutStyle style) {
    selectedStyle = style;
    notifyListeners();
  }

  void selectDate(String dateId) {
    selectedDateId = dateId;
    notifyListeners();
  }

  void selectTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  void setBookingPayment(PaymentMethod method) {
    bookingPayment = method;
    notifyListeners();
  }

  // ----- favorites -----
  late Set<String> favoriteShopIds;

  bool isFavorite(String shopId) => favoriteShopIds.contains(shopId);

  void toggleFavorite(String shopId) {
    if (favoriteShopIds.contains(shopId)) {
      favoriteShopIds.remove(shopId);
    } else {
      favoriteShopIds.add(shopId);
    }
    notifyListeners();
  }

  // ----- bookings -----
  late List<Booking> bookings;

  Booking confirmBooking() {
    final code = '#AH-${4000 + Random().nextInt(999)}';
    final dateOption = MockData.dates.firstWhere((d) => d.id == selectedDateId);
    final booking = Booking(
      code: code,
      shop: selectedShop,
      barber: selectedBarber,
      service: selectedService,
      styleName: selectedStyle.name,
      totalPrice: totalServicePrice,
      dateLabel: '${dateOption.day} ${dateOption.num}',
      time: '${selectedTime ?? ''} م',
      done: false,
      queueAhead: 1,
    );
    bookings.insert(0, booking);
    notifyListeners();
    return booking;
  }

  void rateBooking(Booking booking, double rating) {
    booking.rating = rating;
    notifyListeners();
  }

  // ----- store / cart -----
  final Map<String, int> cart = {};

  int get cartCount => cart.values.fold(0, (a, b) => a + b);

  int get cartTotal {
    return cart.entries.fold(0, (sum, entry) {
      final product = MockData.findProductById(entry.key)!;
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

  // ----- orders -----
  late List<ProductOrder> orders;

  ProductOrder confirmOrder() {
    final code = '#ORD-${1100 + Random().nextInt(899)}';
    final items = cart.entries.map((entry) {
      final product = MockData.findProductById(entry.key)!;
      return OrderItem(name: product.name, qty: entry.value, price: product.price);
    }).toList();
    final order = ProductOrder(
      code: code,
      items: items,
      total: checkoutTotal,
      dateLabel: 'النهاردة',
      status: OrderStatus.processing,
    );
    orders.insert(0, order);
    cart.clear();
    notifyListeners();
    return order;
  }

  // ----- store product / category picker (transient UI state) -----
  String selectedCategory = 'الكل';

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    if (selectedCategory == 'الكل') return MockData.products;
    return MockData.products.where((p) => p.category == selectedCategory).toList();
  }
}
