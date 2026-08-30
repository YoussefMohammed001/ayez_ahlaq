import 'package:flutter/material.dart';
import '../models/product.dart';

class MockData {
  MockData._();

  static const List<String> categories = ['عناية الشعر', 'ذقن ولحية', 'أدوات', 'عطور'];

  static List<Product> buildProducts() => [
        const Product(
          id: 'wax',
          name: 'وكس تشكيل الشعر - تثبيت قوي',
          category: 'عناية الشعر',
          price: 120,
          rating: 4.7,
          gradient: [Color(0xFF8F6C1F), Color(0xFF3A331F)],
          description: 'وكس تثبيت قوي بلمعة طبيعية، مناسب لكل أنواع القصات العصرية.',
          stock: 240,
          minOrderQty: 6,
        ),
        const Product(
          id: 'shampoo',
          name: 'شامبو رجالي ضد القشرة',
          category: 'عناية الشعر',
          price: 95,
          rating: 4.5,
          gradient: [Color(0xFF5C8560), Color(0xFF26311F)],
          description: 'شامبو مخصص لفروة الرأس الحساسة، بيقلل القشرة من أول استخدام.',
          stock: 180,
          minOrderQty: 6,
        ),
        const Product(
          id: 'beardoil',
          name: 'زيت لحية طبيعي',
          category: 'ذقن ولحية',
          price: 85,
          rating: 4.8,
          gradient: [Color(0xFFC1573B), Color(0xFF3A241C)],
          description: 'زيت طبيعي 100% بيرطب اللحية ويقلل الحكة.',
          stock: 300,
          minOrderQty: 12,
        ),
        const Product(
          id: 'trimmer',
          name: 'ماكينة حلاقة كهربائية احترافية',
          category: 'أدوات',
          price: 650,
          rating: 4.9,
          gradient: [Color(0xFF5A4A66), Color(0xFF211C2B)],
          description: 'ماكينة شحن USB بشفرات تيتانيوم، مناسبة للفيد والتشذيب الدقيق.',
          stock: 40,
          minOrderQty: 2,
        ),
        const Product(
          id: 'scissors',
          name: 'مقص تشذيب دقيق',
          category: 'أدوات',
          price: 180,
          rating: 4.6,
          gradient: [Color(0xFF8F6C1F), Color(0xFF26311F)],
          description: 'ستانلس ستيل ياباني، حواف دقيقة جدًا لتشذيب الذقن والحواجب.',
          stock: 65,
          minOrderQty: 3,
        ),
        const Product(
          id: 'shavecream',
          name: 'كريم حلاقة بالصبار',
          category: 'ذقن ولحية',
          price: 60,
          rating: 4.4,
          gradient: [Color(0xFF5C8560), Color(0xFF3A331F)],
          description: 'رغوة ناعمة بخلاصة الصبار، بتقلل تهيج البشرة وتدي حلاقة أنعم.',
          stock: 210,
          minOrderQty: 12,
        ),
        const Product(
          id: 'beardbrush',
          name: 'فرشة لحية خشب طبيعي',
          category: 'ذقن ولحية',
          price: 45,
          rating: 4.3,
          gradient: [Color(0xFF3A331F), Color(0xFF211C2B)],
          description: 'فرشة خشب زان طبيعي بتوزع الزيت بالتساوي وتنظم شعر اللحية.',
          stock: 150,
          minOrderQty: 12,
        ),
        const Product(
          id: 'cologne',
          name: 'كولونيا ما بعد الحلاقة',
          category: 'عطور',
          price: 150,
          rating: 4.7,
          gradient: [Color(0xFFC1573B), Color(0xFF8F6C1F)],
          description: 'إحساس منعش بعد الحلاقة، بيهدي البشرة وريحته تدوم طول اليوم.',
          stock: 95,
          minOrderQty: 6,
        ),
      ];
}
