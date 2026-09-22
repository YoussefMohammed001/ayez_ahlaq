enum SubscriptionStatus {
  active,
  pending,
  paused,
  unknown;

  static SubscriptionStatus fromApi(String? value) => switch (value) {
    'ACTIVE' => SubscriptionStatus.active,
    'PENDING' => SubscriptionStatus.pending,
    'PAUSED' => SubscriptionStatus.paused,
    _ => SubscriptionStatus.unknown,
  };
}
