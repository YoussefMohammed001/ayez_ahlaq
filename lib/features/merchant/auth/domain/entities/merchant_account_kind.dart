enum MerchantAccountKind {
  owner,
  subMerchant;

  static MerchantAccountKind fromApi(String? value) => switch (value) {
    'SUB_MERCHANT' => MerchantAccountKind.subMerchant,
    _ => MerchantAccountKind.owner,
  };

  static MerchantAccountKind fromName(String? value) => values.firstWhere(
    (kind) => kind.name == value,
    orElse: () => MerchantAccountKind.owner,
  );

  bool get isSubMerchant => this == MerchantAccountKind.subMerchant;
}
