enum StorefrontFulfillmentType {
  delivery,
  pickupAtBranch;

  static StorefrontFulfillmentType fromApi(String? value) => switch (value) {
    'PICKUP_AT_BRANCH' => StorefrontFulfillmentType.pickupAtBranch,
    _ => StorefrontFulfillmentType.delivery,
  };
}
