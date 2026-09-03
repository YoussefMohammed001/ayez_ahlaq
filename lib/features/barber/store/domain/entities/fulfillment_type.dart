enum FulfillmentType {
  delivery,
  pickupAtBranch;

  static FulfillmentType fromApi(String? value) => switch (value) {
    'PICKUP_AT_BRANCH' => FulfillmentType.pickupAtBranch,
    _ => FulfillmentType.delivery,
  };

  String toApi() => switch (this) {
    FulfillmentType.delivery => 'DELIVERY',
    FulfillmentType.pickupAtBranch => 'PICKUP_AT_BRANCH',
  };
}
