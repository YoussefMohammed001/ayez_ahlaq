import 'package:equatable/equatable.dart';

class ActiveDiscount extends Equatable {
  final int discountId;
  final String name;
  final String rewardType;
  final num? rewardValue;

  const ActiveDiscount({
    required this.discountId,
    required this.name,
    required this.rewardType,
    this.rewardValue,
  });

  bool get isPercent => rewardType == 'PERCENT';

  @override
  List<Object?> get props => [discountId, name, rewardType, rewardValue];
}
