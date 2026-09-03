enum StorefrontOrderStatus {
  pending,
  accepted,
  preparing,
  readyForPickup,
  outForDelivery,
  delivered,
  rejected,
  cancelled;

  static StorefrontOrderStatus fromApi(String? value) => switch (value) {
    'PENDING' => StorefrontOrderStatus.pending,
    'ACCEPTED' => StorefrontOrderStatus.accepted,
    'PREPARING' => StorefrontOrderStatus.preparing,
    'READY_FOR_PICKUP' => StorefrontOrderStatus.readyForPickup,
    'OUT_FOR_DELIVERY' => StorefrontOrderStatus.outForDelivery,
    'DELIVERED' => StorefrontOrderStatus.delivered,
    'REJECTED' => StorefrontOrderStatus.rejected,
    'CANCELLED' => StorefrontOrderStatus.cancelled,
    _ => StorefrontOrderStatus.pending,
  };

  String toApi() => switch (this) {
    StorefrontOrderStatus.pending => 'PENDING',
    StorefrontOrderStatus.accepted => 'ACCEPTED',
    StorefrontOrderStatus.preparing => 'PREPARING',
    StorefrontOrderStatus.readyForPickup => 'READY_FOR_PICKUP',
    StorefrontOrderStatus.outForDelivery => 'OUT_FOR_DELIVERY',
    StorefrontOrderStatus.delivered => 'DELIVERED',
    StorefrontOrderStatus.rejected => 'REJECTED',
    StorefrontOrderStatus.cancelled => 'CANCELLED',
  };

  bool get isTerminal =>
      this == StorefrontOrderStatus.delivered ||
      this == StorefrontOrderStatus.rejected ||
      this == StorefrontOrderStatus.cancelled;

  bool get needsDecision => this == StorefrontOrderStatus.pending;
}
