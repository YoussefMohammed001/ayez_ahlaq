enum RewardType {
  percent,
  amount,
  free;

  static RewardType fromApi(String? value) => switch (value) {
    'AMOUNT' => RewardType.amount,
    'FREE' => RewardType.free,
    _ => RewardType.percent,
  };

  String toApi() => switch (this) {
    RewardType.percent => 'PERCENT',
    RewardType.amount => 'AMOUNT',
    RewardType.free => 'FREE',
  };


  bool get needsValue => this != RewardType.free;

  bool get isPercent => this == RewardType.percent;

  bool get isAmount => this == RewardType.amount;
}
