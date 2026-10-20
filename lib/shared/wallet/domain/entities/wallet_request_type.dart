enum WalletRequestType {
  deposit,
  withdraw;

  static WalletRequestType fromApi(String? value) => switch (value) {
    'WITHDRAW' => WalletRequestType.withdraw,
    _ => WalletRequestType.deposit,
  };

  String toApi() => switch (this) {
    WalletRequestType.deposit => 'DEPOSIT',
    WalletRequestType.withdraw => 'WITHDRAW',
  };
}
