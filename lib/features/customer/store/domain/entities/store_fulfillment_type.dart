enum StoreFulfillmentType {
  delivery,
  pickupAtBranch;

  String toApi() => switch (this) {
    StoreFulfillmentType.delivery => 'DELIVERY',
    StoreFulfillmentType.pickupAtBranch => 'PICKUP_AT_BRANCH',
  };
}
