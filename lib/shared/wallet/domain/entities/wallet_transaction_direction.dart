enum WalletTransactionDirection {
  credit,
  debit;

  static WalletTransactionDirection fromApi(String? value) => switch (value) {
    'DEBIT' => WalletTransactionDirection.debit,
    _ => WalletTransactionDirection.credit,
  };
}
