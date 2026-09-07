import '../../domain/entities/active_discount.dart';
import '../../../../../../generated/l10n.dart';

extension ActiveDiscountLabel on ActiveDiscount {
  String get valueLabel {
    final value = rewardValue;
    if (value == null) return name;
    return isPercent
        ? S().unitDiscountPercentLabel(value.round())
        : S().currencyEgp(value.round());
  }
}
