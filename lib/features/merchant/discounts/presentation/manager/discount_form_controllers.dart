import 'package:flutter/widgets.dart';
import '../../data/requests/discount_request.dart';
import '../../domain/entities/discount.dart';
import '../../domain/entities/discount_scope.dart';
import '../../domain/entities/reward_type.dart';

class DiscountFormControllers {
  final TextEditingController name;
  final TextEditingController rewardValue;
  final TextEditingController buyQuantity;
  final TextEditingController rewardQuantity;
  final TextEditingController minOrderTotal;

  DiscountScope scope;
  RewardType rewardType;
  int? targetProductId;
  List<int> shopIds;

  DiscountFormControllers([Discount? discount])
    : name = TextEditingController(text: discount?.name),
      rewardValue = TextEditingController(
        text: discount?.rewardValue?.toString(),
      ),
      buyQuantity = TextEditingController(
        text: discount?.buyQuantity?.toString() ?? '4',
      ),
      rewardQuantity = TextEditingController(
        text: discount?.rewardQuantity?.toString() ?? '1',
      ),
      minOrderTotal = TextEditingController(
        text: discount?.minOrderTotal?.toString() ?? '1000',
      ),
      scope = discount?.scope ?? DiscountScope.product,
      rewardType = discount?.rewardType ?? RewardType.percent,
      targetProductId = discount?.targetProductId,
      shopIds = discount?.shops.map((s) => s.id).toList() ?? const [];

  List<RewardType> get rewardOptions => switch (scope) {
    DiscountScope.product => [RewardType.percent, RewardType.amount],
    DiscountScope.buyXGetY => RewardType.values,
    DiscountScope.orderTotal => [RewardType.percent, RewardType.amount],
  };

  void onScopeChanged(DiscountScope value) {
    scope = value;
    if (!rewardOptions.contains(rewardType)) {
      rewardType = rewardOptions.first;
    }
  }

  DiscountRequest buildRequest() {
    return DiscountRequest(
      name: name.text.trim(),
      scope: scope,
      rewardType: rewardType,
      rewardValue: rewardType.needsValue
          ? num.tryParse(rewardValue.text)
          : null,
      targetProductId: scope.needsProduct ? targetProductId : null,
      buyQuantity: scope == DiscountScope.buyXGetY
          ? int.tryParse(buyQuantity.text)
          : null,
      rewardQuantity: scope == DiscountScope.buyXGetY
          ? int.tryParse(rewardQuantity.text)
          : null,
      minOrderTotal: scope == DiscountScope.orderTotal
          ? int.tryParse(minOrderTotal.text)
          : null,
      shopIds: shopIds,
    );
  }

  void dispose() {
    name.dispose();
    rewardValue.dispose();
    buyQuantity.dispose();
    rewardQuantity.dispose();
    minOrderTotal.dispose();
  }
}
