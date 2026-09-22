import '../../../../merchant/discounts/domain/entities/discount_scope.dart';
import '../../../../merchant/discounts/domain/entities/reward_type.dart';

class BarberDiscountRequest {
  final String name;
  final DiscountScope scope;
  final RewardType rewardType;
  final num? rewardValue;
  final int? targetProductId;
  final int? buyQuantity;
  final int? rewardQuantity;
  final int? rewardProductId;
  final int? minOrderTotal;

  const BarberDiscountRequest({
    required this.name,
    required this.scope,
    required this.rewardType,
    this.rewardValue,
    this.targetProductId,
    this.buyQuantity,
    this.rewardQuantity,
    this.rewardProductId,
    this.minOrderTotal,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'scope': scope.toApi(),
    'rewardType': rewardType.toApi(),
    if (rewardValue != null) 'rewardValue': rewardValue,
    if (targetProductId != null) 'targetProductId': targetProductId,
    if (buyQuantity != null) 'buyQuantity': buyQuantity,
    if (rewardQuantity != null) 'rewardQuantity': rewardQuantity,
    if (rewardProductId != null) 'rewardProductId': rewardProductId,
    if (minOrderTotal != null) 'minOrderTotal': minOrderTotal,
  };
}
