import 'package:equatable/equatable.dart';

class StoreFeedProduct extends Equatable {
  final int id;
  final String name;
  final String? brand;
  final int price;
  final int effectivePrice;
  final bool inStock;
  final double rating;
  final int minOrderQty;
  final int merchantId;
  final String merchantName;
  final double merchantRating;
  final double? distanceKm;
  final bool deliveryOffered;
  final List<String> badges;

  const StoreFeedProduct({
    required this.id,
    required this.name,
    this.brand,
    required this.price,
    required this.effectivePrice,
    required this.inStock,
    required this.rating,
    required this.minOrderQty,
    required this.merchantId,
    required this.merchantName,
    required this.merchantRating,
    this.distanceKm,
    required this.deliveryOffered,
    this.badges = const [],
  });

  bool get isDiscounted => effectivePrice < price;

  int get discountPercent =>
      price <= 0 ? 0 : (((price - effectivePrice) / price) * 100).round();

  bool get isSponsored => badges.contains('sponsored');

  bool get wasOrderedBefore => badges.contains('ordered');

  @override
  List<Object?> get props => [
    id,
    name,
    brand,
    price,
    effectivePrice,
    inStock,
    rating,
    minOrderQty,
    merchantId,
    merchantName,
    merchantRating,
    distanceKm,
    deliveryOffered,
    badges,
  ];
}
