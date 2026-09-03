enum StoreOrderStatus {
  pending,
  accepted,
  preparing,
  readyForPickup,
  outForDelivery,
  delivered,
  rejected,
  cancelled;

  static StoreOrderStatus fromApi(String? value) => switch (value) {
    'PENDING' => StoreOrderStatus.pending,
    'ACCEPTED' => StoreOrderStatus.accepted,
    'PREPARING' => StoreOrderStatus.preparing,
    'READY_FOR_PICKUP' => StoreOrderStatus.readyForPickup,
    'OUT_FOR_DELIVERY' => StoreOrderStatus.outForDelivery,
    'DELIVERED' => StoreOrderStatus.delivered,
    'REJECTED' => StoreOrderStatus.rejected,
    'CANCELLED' => StoreOrderStatus.cancelled,
    _ => StoreOrderStatus.pending,
  };

  bool get isTerminal =>
      this == StoreOrderStatus.delivered ||
      this == StoreOrderStatus.rejected ||
      this == StoreOrderStatus.cancelled;

  bool get canCancel => this == StoreOrderStatus.pending;
}
