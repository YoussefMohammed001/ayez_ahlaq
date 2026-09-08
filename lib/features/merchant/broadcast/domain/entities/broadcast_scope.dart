enum BroadcastScope {
  zone,
  all,
  other;

  static BroadcastScope fromApi(String? value) => switch (value) {
    'ZONE' => BroadcastScope.zone,
    'ALL' => BroadcastScope.all,
    _ => BroadcastScope.other,
  };
}
