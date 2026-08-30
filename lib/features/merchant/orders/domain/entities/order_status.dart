enum OrderStatus {
  pending,
  accepted,
  preparing,
  readyForPickup,
  outForDelivery,
  delivered,
  rejected,
  cancelled;

  static OrderStatus fromApi(String? value) => switch (value) {
    'PENDING' => OrderStatus.pending,
    'ACCEPTED' => OrderStatus.accepted,
    'PREPARING' => OrderStatus.preparing,
    'READY_FOR_PICKUP' => OrderStatus.readyForPickup,
    'OUT_FOR_DELIVERY' => OrderStatus.outForDelivery,
    'DELIVERED' => OrderStatus.delivered,
    'REJECTED' => OrderStatus.rejected,
    'CANCELLED' => OrderStatus.cancelled,
    _ => OrderStatus.pending,
  };

  String toApi() => switch (this) {
    OrderStatus.pending => 'PENDING',
    OrderStatus.accepted => 'ACCEPTED',
    OrderStatus.preparing => 'PREPARING',
    OrderStatus.readyForPickup => 'READY_FOR_PICKUP',
    OrderStatus.outForDelivery => 'OUT_FOR_DELIVERY',
    OrderStatus.delivered => 'DELIVERED',
    OrderStatus.rejected => 'REJECTED',
    OrderStatus.cancelled => 'CANCELLED',
  };


  bool get isTerminal =>
      this == OrderStatus.delivered ||
      this == OrderStatus.rejected ||
      this == OrderStatus.cancelled;

  bool get needsDecision => this == OrderStatus.pending;
}
