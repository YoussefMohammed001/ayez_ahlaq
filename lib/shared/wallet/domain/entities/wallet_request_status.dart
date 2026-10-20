enum WalletRequestStatus {
  pending,
  approved,
  rejected,
  cancelled,
  other;

  static WalletRequestStatus fromApi(String? value) => switch (value) {
    'PENDING' => WalletRequestStatus.pending,
    'APPROVED' => WalletRequestStatus.approved,
    'REJECTED' => WalletRequestStatus.rejected,
    'CANCELLED' => WalletRequestStatus.cancelled,
    _ => WalletRequestStatus.other,
  };
}
