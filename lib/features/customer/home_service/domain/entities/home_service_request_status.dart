enum HomeServiceRequestStatus {
  pending,
  accepted,
  onTheWay,
  done,
  rejected,
  cancelled;

  static HomeServiceRequestStatus fromApi(String? value) => switch (value) {
    'PENDING' => HomeServiceRequestStatus.pending,
    'ACCEPTED' => HomeServiceRequestStatus.accepted,
    'ON_THE_WAY' => HomeServiceRequestStatus.onTheWay,
    'DONE' => HomeServiceRequestStatus.done,
    'REJECTED' => HomeServiceRequestStatus.rejected,
    'CANCELLED' => HomeServiceRequestStatus.cancelled,
    _ => HomeServiceRequestStatus.pending,
  };

  bool get isPast =>
      this == HomeServiceRequestStatus.done ||
      this == HomeServiceRequestStatus.rejected ||
      this == HomeServiceRequestStatus.cancelled;

  bool get isCancellable => this == HomeServiceRequestStatus.pending;
}
