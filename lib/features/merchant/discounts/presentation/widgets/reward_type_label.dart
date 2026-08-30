import '../../../../../generated/l10n.dart';
import '../../domain/entities/reward_type.dart';

extension RewardTypeLabel on RewardType {
  String get label => switch (this) {
    RewardType.percent => S().rewardPercent,
    RewardType.amount => S().rewardAmount,
    RewardType.free => S().rewardFree,
  };
}
