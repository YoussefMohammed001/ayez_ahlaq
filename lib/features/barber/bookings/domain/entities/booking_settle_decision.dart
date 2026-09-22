enum BookingSettleDecision {
  approve,
  cancel;

  String toApi() => switch (this) {
    BookingSettleDecision.approve => 'APPROVE',
    BookingSettleDecision.cancel => 'CANCEL',
  };
}
