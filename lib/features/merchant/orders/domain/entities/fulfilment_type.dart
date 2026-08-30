enum FulfilmentType {
  delivery,
  pickupAtBranch;

  static FulfilmentType fromApi(String? value) => switch (value) {
    'PICKUP_AT_BRANCH' => FulfilmentType.pickupAtBranch,
    _ => FulfilmentType.delivery,
  };

}
