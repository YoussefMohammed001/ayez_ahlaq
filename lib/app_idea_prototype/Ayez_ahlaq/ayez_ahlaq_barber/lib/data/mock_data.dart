import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/week_day.dart';
import '../models/shop_service.dart';
import '../models/team_member.dart';

class MockData {
  MockData._();

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

  static List<ShopService> buildServices() => [
        ShopService(id: 'cut', name: 'قصة شعر عادية', price: 100, durationMinutes: 30),
        ShopService(id: 'cutbeard', name: 'قصة + تهذيب ذقن', price: 150, durationMinutes: 45),
        ShopService(id: 'color', name: 'قصة + صبغة', price: 280, durationMinutes: 75),
        ShopService(id: 'beard', name: 'حلاقة ذقن فقط', price: 70, durationMinutes: 20),
        ShopService(id: 'kids', name: 'قصة أطفال', price: 80, durationMinutes: 25, active: false),
      ];

  static List<WeekDay> buildWeek() => [
        WeekDay(day: 'السبت', hours: '10:00 ص - 11:00 م'),
        WeekDay(day: 'الأحد', hours: '10:00 ص - 11:00 م', isToday: true),
        WeekDay(day: 'الاتنين', hours: '10:00 ص - 11:00 م'),
        WeekDay(day: 'التلات', hours: '10:00 ص - 11:00 م'),
        WeekDay(day: 'الأربع', hours: '10:00 ص - 11:00 م'),
        WeekDay(day: 'الخميس', hours: '12:00 م - 12:00 ص'),
        WeekDay(day: 'الجمعة', hours: 'إجازة', isOff: true),
      ];

  static const List<Review> reviews = [
    Review(name: 'مختار توفيق', stars: 5, date: 'قبل أسبوعين', text: 'فيد نضيف جدًا ودقة عالية، هرجعله تاني أكيد.'),
    Review(name: 'ياسر منير', stars: 5, date: 'قبل 3 أسابيع', text: 'محترم في المواعيد ومحدش استناني، ده اللي عجبني.'),
    Review(name: 'حسام الدين', stars: 4, date: 'الشهر اللي فات', text: 'شغل تمام بس الصالون كان مزحوم شوية وقتها.'),
    Review(name: 'أوس ماهر', stars: 5, date: 'الشهر اللي فات', text: 'أحسن حلاق جربته في المنطقة، بينصح صح مش بس بيقص.'),
  ];

  /// Performance snapshot for every barber working at صالون الملك this
  /// month — powers the "الفريق" tab. محمد سعيد (this account) is flagged
  /// via [TeamMember.isYou] so the tab can highlight "أنت" on his card.
  static const List<TeamMember> team = [
    TeamMember(name: 'محمد سعيد', tag: 'فيد وتصفيف عصري', clientsThisMonth: 142, rating: 4.9, isYou: true),
    TeamMember(name: 'أحمد ناصر', tag: 'قصات كلاسيك', clientsThisMonth: 121, rating: 4.8),
    TeamMember(name: 'كريم عادل', tag: 'ذقن وصبغة', clientsThisMonth: 98, rating: 4.7),
    TeamMember(name: 'حسن جمال', tag: 'حلاقة عصرية', clientsThisMonth: 76, rating: 4.6),
  ];

  static const List<Color> portfolio = [
    Color(0xFF8F6C1F),
    Color(0xFF5C8560),
    Color(0xFF5A4A66),
    Color(0xFFC1573B),
    Color(0xFF26311F),
    Color(0xFF3A331F),
  ];
}
