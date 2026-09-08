enum BroadcastStatus {
  pending,
  approved,
  rejected,
  other;

  static BroadcastStatus fromApi(String? value) => switch (value) {
    'PENDING' => BroadcastStatus.pending,
    'APPROVED' => BroadcastStatus.approved,
    'REJECTED' => BroadcastStatus.rejected,
    _ => BroadcastStatus.other,
  };
}
