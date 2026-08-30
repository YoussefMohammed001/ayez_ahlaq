import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../models/barber.dart';
import '../models/service.dart';
import '../models/product.dart';
import '../models/time_slot.dart';
import '../models/haircut_style.dart';

/// All mock/demo data for the prototype lives here. Swap these for real
/// API calls once a backend exists — nothing else in the app should need
/// to change shape.
class MockData {
  MockData._();

  static const Map<String, Shop> allShops = {
    'malek': Shop(
      id: 'malek',
      name: 'صالون الملك',
      rating: 4.9,
      reviews: 410,
      distance: '800 م',
      area: 'مدينة نصر',
      open: true,
      closesAt: '12:00 ص',
      tags: ['قص', 'ذقن', 'صبغة'],
      gradient: [Color(0xFF8F6C1F), Color(0xFF3A331F)],
    ),
    'asala': Shop(
      id: 'asala',
      name: 'صالون الأصالة',
      rating: 4.8,
      reviews: 320,
      distance: '1.2 كم',
      area: 'مدينة نصر',
      open: true,
      closesAt: '11:00 م',
      tags: ['قص', 'ذقن'],
      gradient: [Color(0xFF5C8560), Color(0xFF26311F)],
    ),
    'barberhouse': Shop(
      id: 'barberhouse',
      name: 'Barber House',
      rating: 4.6,
      reviews: 150,
      distance: '2.5 كم',
      area: 'مصر الجديدة',
      open: false,
      closesAt: 'يفتح 10 ص',
      tags: ['قص', 'صبغة'],
      gradient: [Color(0xFF5A4A66), Color(0xFF211C2B)],
    ),
    'hassan': Shop(
      id: 'hassan',
      name: 'كابتن حسن',
      rating: 4.9,
      reviews: 530,
      distance: '950 م',
      area: 'مدينة نصر',
      open: true,
      closesAt: '11:00 م',
      tags: ['قص', 'ذقن كلاسيك'],
      gradient: [Color(0xFFC1573B), Color(0xFF3A241C)],
    ),
  };

  static const List<String> nearbyShopIds = ['malek', 'asala', 'barberhouse'];

  /// The shop id a customer arrives with when opening the app from a
  /// barber's referral link — gets auto-pinned into favorites.
  static const String viaLinkShopId = 'hassan';

  static const List<Barber> barbers = [
    Barber(
      id: 'mohamed',
      name: 'محمد سعيد',
      tag: 'فيد وتصفيف عصري',
      rating: 4.9,
      status: 'شغال دلوقتي',
      ok: true,
      portfolio: [Color(0xFF8F6C1F), Color(0xFF5C8560), Color(0xFF5A4A66)],
    ),
    Barber(
      id: 'karim',
      name: 'كريم عادل',
      tag: 'ذقن وصبغة',
      rating: 4.7,
      status: 'مشغول لحد 3:15',
      ok: false,
      portfolio: [Color(0xFFC1573B), Color(0xFF8F6C1F), Color(0xFF26311F)],
    ),
    Barber(
      id: 'ahmed',
      name: 'أحمد ناصر',
      tag: 'قصات كلاسيك',
      rating: 4.8,
      status: 'شغال دلوقتي',
      ok: true,
      portfolio: [Color(0xFF5C8560), Color(0xFF3A331F), Color(0xFFC1573B)],
    ),
  ];

  static const List<BarberService> services = [
    BarberService(id: 'cut', name: 'قصة شعر عادية', desc: 'غسيل + قص + تصفيف', price: 100, durationMinutes: 30),
    BarberService(id: 'cutbeard', name: 'قصة + تهذيب ذقن', desc: 'الأكثر طلبًا', price: 150, durationMinutes: 45, popular: true),
    BarberService(id: 'color', name: 'قصة + صبغة', desc: 'صبغة أمونيا فري', price: 280, durationMinutes: 75),
    BarberService(id: 'beard', name: 'حلاقة ذقن فقط', desc: 'موس + تسخين فوطة', price: 70, durationMinutes: 20),
    BarberService(id: 'kids', name: 'قصة أطفال', desc: 'لحد 12 سنة', price: 80, durationMinutes: 25),
  ];

  /// Named haircut looks the customer picks after the general service —
  /// e.g. "قصة عادية" (service) then "مولت" (style). Each has its own
  /// price add-on since some cuts take more of the barber's time.
  static const List<HaircutStyle> haircutStyles = [
    HaircutStyle(id: 'classic', name: 'كلاسيك', priceDelta: 0, swatch: [Color(0xFF5C8560), Color(0xFF26311F)]),
    HaircutStyle(id: 'fade', name: 'فيد أمريكي', priceDelta: 0, swatch: [Color(0xFF8F6C1F), Color(0xFF3A331F)]),
    HaircutStyle(id: 'mullet', name: 'مولت', priceDelta: 30, swatch: [Color(0xFFC1573B), Color(0xFF3A241C)]),
    HaircutStyle(id: 'undercut', name: 'أندركت', priceDelta: 20, swatch: [Color(0xFF5A4A66), Color(0xFF211C2B)]),
    HaircutStyle(id: 'pompadour', name: 'بومبادور', priceDelta: 25, swatch: [Color(0xFFA97F26), Color(0xFF3A331F)]),
    HaircutStyle(id: 'buzz', name: 'باز كت', priceDelta: -10, swatch: [Color(0xFF3A331F), Color(0xFF211C2B)]),
    HaircutStyle(id: 'crew', name: 'كريو كت', priceDelta: 15, swatch: [Color(0xFF6E93A8), Color(0xFF26311F)]),
    HaircutStyle(id: 'shag', name: 'شاغ مجعد', priceDelta: 35, swatch: [Color(0xFFC1573B), Color(0xFF8F6C1F)]),
  ];

  static const List<DateOption> dates = [
    DateOption(id: 'd0', day: 'سبت', num: 19),
    DateOption(id: 'd1', day: 'حد', num: 20),
    DateOption(id: 'd2', day: 'اتنين', num: 21),
    DateOption(id: 'd3', day: 'تلات', num: 22),
    DateOption(id: 'd4', day: 'أربع', num: 23),
  ];

  static const List<TimeSlot> timeSlots = [
    TimeSlot(time: '10:00', status: SlotStatus.booked),
    TimeSlot(time: '10:30', status: SlotStatus.booked),
    TimeSlot(time: '11:00', status: SlotStatus.available),
    TimeSlot(time: '11:30', status: SlotStatus.available, queueAhead: 2),
    TimeSlot(time: '12:00', status: SlotStatus.available),
    TimeSlot(time: '12:30', status: SlotStatus.available),
    TimeSlot(time: '1:00', status: SlotStatus.booked),
    TimeSlot(time: '1:30', status: SlotStatus.available),
    TimeSlot(time: '2:00', status: SlotStatus.available, queueAhead: 1),
    TimeSlot(time: '2:30', status: SlotStatus.available),
    TimeSlot(time: '3:00', status: SlotStatus.booked),
    TimeSlot(time: '3:30', status: SlotStatus.available),
  ];

  static const List<String> productCategories = ['الكل', 'عناية الشعر', 'ذقن ولحية', 'أدوات', 'عطور'];

  static const List<Product> products = [
    Product(
      id: 'wax',
      name: 'وكس تشكيل الشعر - تثبيت قوي',
      category: 'عناية الشعر',
      price: 120,
      rating: 4.7,
      gradient: [Color(0xFF8F6C1F), Color(0xFF3A331F)],
      description: 'وكس تثبيت قوي بلمعة طبيعية، مناسب لكل أنواع القصات العصرية. يدوم طول اليوم من غير ما يخلي الشعر متيبس.',
    ),
    Product(
      id: 'shampoo',
      name: 'شامبو رجالي ضد القشرة',
      category: 'عناية الشعر',
      price: 95,
      rating: 4.5,
      gradient: [Color(0xFF5C8560), Color(0xFF26311F)],
      description: 'شامبو مخصص لفروة الرأس الحساسة، بيقلل القشرة من أول استخدام وريحته تدوم.',
    ),
    Product(
      id: 'beardoil',
      name: 'زيت لحية طبيعي',
      category: 'ذقن ولحية',
      price: 85,
      rating: 4.8,
      gradient: [Color(0xFFC1573B), Color(0xFF3A241C)],
      description: 'زيت طبيعي 100% بيرطب اللحية ويقلل الحكة، ويدي مظهر صحي ولمعان خفيف.',
    ),
    Product(
      id: 'trimmer',
      name: 'ماكينة حلاقة كهربائية احترافية',
      category: 'أدوات',
      price: 650,
      rating: 4.9,
      gradient: [Color(0xFF5A4A66), Color(0xFF211C2B)],
      description: 'ماكينة شحن USB بشفرات تيتانيوم، مناسبة للفيد والتشذيب الدقيق، شحنة تدوم 90 دقيقة استخدام.',
    ),
    Product(
      id: 'scissors',
      name: 'مقص تشذيب دقيق',
      category: 'أدوات',
      price: 180,
      rating: 4.6,
      gradient: [Color(0xFF8F6C1F), Color(0xFF26311F)],
      description: 'ستانلس ستيل ياباني، حواف دقيقة جدًا لتشذيب الذقن والحواجب.',
    ),
    Product(
      id: 'shavecream',
      name: 'كريم حلاقة بالصبار',
      category: 'ذقن ولحية',
      price: 60,
      rating: 4.4,
      gradient: [Color(0xFF5C8560), Color(0xFF3A331F)],
      description: 'رغوة ناعمة بخلاصة الصبار، بتقلل تهيج البشرة وتدي حلاقة أنعم.',
    ),
    Product(
      id: 'beardbrush',
      name: 'فرشة لحية خشب طبيعي',
      category: 'ذقن ولحية',
      price: 45,
      rating: 4.3,
      gradient: [Color(0xFF3A331F), Color(0xFF211C2B)],
      description: 'فرشة خشب زان طبيعي بتوزع الزيت بالتساوي وتنظم شعر اللحية.',
    ),
    Product(
      id: 'cologne',
      name: 'كولونيا ما بعد الحلاقة',
      category: 'عطور',
      price: 150,
      rating: 4.7,
      gradient: [Color(0xFFC1573B), Color(0xFF8F6C1F)],
      description: 'إحساس منعش بعد الحلاقة، بيهدي البشرة وريحته تدوم طول اليوم.',
    ),
  ];

  /// Products a barber lists for sale himself (managed from "منتجاتي" in
  /// his own app), keyed by barber id — separate from the wholesale
  /// [products] catalog above, which merchants sell to barbers, not to
  /// customers. Shown on [ShopDetailScreen] under "منتجات الحلاق".
  /// Looks up a product by id across both the wholesale [products] catalog
  /// and every barber's own [barberOwnedProducts] listings — the cart
  /// doesn't care which shelf an item came from.
  static Product? findProductById(String id) {
    for (final p in products) {
      if (p.id == id) return p;
    }
    for (final list in barberOwnedProducts.values) {
      for (final p in list) {
        if (p.id == id) return p;
      }
    }
    return null;
  }

  static const Map<String, List<Product>> barberOwnedProducts = {
    'mohamed': [
      Product(
        id: 'mohamed-pomade',
        name: 'بوماد الصالون الخاص بمحمد سعيد',
        category: 'عناية الشعر',
        price: 140,
        rating: 5.0,
        gradient: [Color(0xFFA97F26), Color(0xFF3A331F)],
        description: 'خلطة البوماد اللي بيستخدمها محمد سعيد في الصالون نفسه، بتثبيت وسط ولمعة طبيعية.',
      ),
      Product(
        id: 'mohamed-beardkit',
        name: 'طقم عناية باللحية - توصية محمد سعيد',
        category: 'ذقن ولحية',
        price: 210,
        rating: 4.9,
        gradient: [Color(0xFFC1573B), Color(0xFF3A241C)],
        description: 'زيت + بلسم + فرشة، نفس الطقم اللي بينصح بيه عملاؤه بعد كل حلاقة.',
      ),
    ],
  };
}
