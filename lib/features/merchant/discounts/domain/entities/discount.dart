import 'package:equatable/equatable.dart';
import 'discount_scope.dart';
import 'discount_shop.dart';
import 'reward_type.dart';

class Discount extends Equatable {
  final int id;
  final String name;
  final DiscountScope scope;
  final RewardType rewardType;
  final bool active;
  final bool liveNow;
  final String summary;
  final num? rewardValue;
  final int? targetProductId;
  final String? targetProductName;
  final int? buyQuantity;
  final int? rewardQuantity;
  final int? minOrderTotal;
  final List<DiscountShop> shops;
  final DateTime? createdAt;

  const Discount({
    required this.id,
    required this.name,
    required this.scope,
    required this.rewardType,
    required this.active,
    required this.liveNow,
    required this.summary,
    required this.shops,
    this.rewardValue,
    this.targetProductId,
    this.targetProductName,
    this.buyQuantity,
    this.rewardQuantity,
    this.minOrderTotal,
    this.createdAt,
  });

  bool get isClosed => !active;

  bool get isAllShops => shops.isEmpty;

  @override
  List<Object?> get props => [id, name, scope, active, liveNow, summary];
}
