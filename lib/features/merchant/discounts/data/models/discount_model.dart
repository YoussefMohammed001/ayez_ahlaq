import '../../domain/entities/discount.dart';
import '../../domain/entities/discount_scope.dart';
import '../../domain/entities/reward_type.dart';
import 'discount_shop_model.dart';

class DiscountModel extends Discount {
  const DiscountModel({
    required super.id,
    required super.name,
    required super.scope,
    required super.rewardType,
    required super.active,
    required super.liveNow,
    required super.summary,
    required super.shops,
    super.rewardValue,
    super.targetProductId,
    super.targetProductName,
    super.buyQuantity,
    super.rewardQuantity,
    super.minOrderTotal,
    super.createdAt,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    final shops = (json['shops'] as List?) ?? const [];

    return DiscountModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      scope: DiscountScope.fromApi(json['scope'] as String?),
      rewardType: RewardType.fromApi(json['rewardType'] as String?),
      active: json['active'] as bool? ?? false,
      liveNow: json['liveNow'] as bool? ?? false,
      summary: json['summary'] as String? ?? '',
      rewardValue: json['rewardValue'] as num?,
      targetProductId: (json['targetProductId'] as num?)?.toInt(),
      targetProductName: json['targetProductName'] as String?,
      buyQuantity: (json['buyQuantity'] as num?)?.toInt(),
      rewardQuantity: (json['rewardQuantity'] as num?)?.toInt(),
      minOrderTotal: (json['minOrderTotal'] as num?)?.toInt(),
      shops: shops
          .map<DiscountShopModel>(
            (e) => DiscountShopModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
