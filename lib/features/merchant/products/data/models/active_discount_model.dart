import '../../domain/entities/active_discount.dart';

class ActiveDiscountModel extends ActiveDiscount {
  const ActiveDiscountModel({
    required super.discountId,
    required super.name,
    required super.rewardType,
    super.rewardValue,
  });

  factory ActiveDiscountModel.fromJson(Map<String, dynamic> json) {
    return ActiveDiscountModel(
      discountId: json['discountId'] as int,
      name: json['name'] as String? ?? '',
      rewardType: json['rewardType'] as String? ?? '',
      rewardValue: json['rewardValue'] as num?,
    );
  }
}
