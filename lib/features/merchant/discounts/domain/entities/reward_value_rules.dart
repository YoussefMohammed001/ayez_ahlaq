import 'reward_type.dart';

class RewardValueRules {
  static const int maxPercent = 100;

  static bool exceedsPercent(RewardType type, num value) {
    return type.isPercent && value > maxPercent;
  }

  static bool exceedsCeiling(RewardType type, num value, int? ceiling) {
    if (!type.isAmount || ceiling == null || ceiling <= 0) return false;

    return value >= ceiling;
  }
}
