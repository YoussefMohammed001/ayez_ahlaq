enum BroadcastScope {
  mine,
  all,
  other;

  static BroadcastScope fromApi(String? value) => switch (value) {
    'MINE' => BroadcastScope.mine,
    'ALL' => BroadcastScope.all,
    _ => BroadcastScope.other,
  };
}
