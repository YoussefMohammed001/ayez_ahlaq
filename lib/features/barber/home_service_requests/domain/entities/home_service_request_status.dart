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

  String toApi() => switch (this) {
    HomeServiceRequestStatus.pending => 'PENDING',
    HomeServiceRequestStatus.accepted => 'ACCEPTED',
    HomeServiceRequestStatus.onTheWay => 'ON_THE_WAY',
    HomeServiceRequestStatus.done => 'DONE',
    HomeServiceRequestStatus.rejected => 'REJECTED',
    HomeServiceRequestStatus.cancelled => 'CANCELLED',
  };

  bool get needsDecision => this == HomeServiceRequestStatus.pending;

  bool get isTerminal =>
      this == HomeServiceRequestStatus.done ||
      this == HomeServiceRequestStatus.rejected ||
      this == HomeServiceRequestStatus.cancelled;
}
