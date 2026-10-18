enum HomeServiceRequestStatus {
  pending,
  accepted,
  onTheWay,
  done,
  rejected,
  cancelled,
  expired;

  static HomeServiceRequestStatus fromApi(String? value) => switch (value) {
    'PENDING' => HomeServiceRequestStatus.pending,
    'ACCEPTED' => HomeServiceRequestStatus.accepted,
    'ON_THE_WAY' => HomeServiceRequestStatus.onTheWay,
    'DONE' => HomeServiceRequestStatus.done,
    'REJECTED' => HomeServiceRequestStatus.rejected,
    'CANCELLED' => HomeServiceRequestStatus.cancelled,
    'EXPIRED' => HomeServiceRequestStatus.expired,
    _ => HomeServiceRequestStatus.pending,
  };

  bool get isPast =>
      this == HomeServiceRequestStatus.done ||
      this == HomeServiceRequestStatus.rejected ||
      this == HomeServiceRequestStatus.cancelled ||
      this == HomeServiceRequestStatus.expired;

  bool get isCancellable => this == HomeServiceRequestStatus.pending;

  bool get isRetryable => this == HomeServiceRequestStatus.expired;
}
