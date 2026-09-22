import 'package:equatable/equatable.dart';
import '../../../../merchant/discounts/domain/entities/discount_scope.dart';
import '../../../../merchant/discounts/domain/entities/reward_type.dart';

class BarberDiscount extends Equatable {
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
  final DateTime? createdAt;

  const BarberDiscount({
    required this.id,
    required this.name,
    required this.scope,
    required this.rewardType,
    required this.active,
    required this.liveNow,
    required this.summary,
    this.rewardValue,
    this.targetProductId,
    this.targetProductName,
    this.buyQuantity,
    this.rewardQuantity,
    this.minOrderTotal,
    this.createdAt,
  });

  bool get isClosed => !active;

  @override
  List<Object?> get props => [
    id,
    name,
    scope,
    rewardType,
    active,
    liveNow,
    summary,
    rewardValue,
    targetProductId,
    targetProductName,
    buyQuantity,
    rewardQuantity,
    minOrderTotal,
    createdAt,
  ];
}
