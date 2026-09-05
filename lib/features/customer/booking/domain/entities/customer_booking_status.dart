enum CustomerBookingStatus {
  pending,
  confirmed,
  upcoming,
  next,
  active,
  done,
  noShow,
  rejected,
  cancelled;

  static CustomerBookingStatus fromApi(String? value) => switch (value) {
    'PENDING' => CustomerBookingStatus.pending,
    'CONFIRMED' => CustomerBookingStatus.confirmed,
    'UPCOMING' => CustomerBookingStatus.upcoming,
    'NEXT' => CustomerBookingStatus.next,
    'ACTIVE' => CustomerBookingStatus.active,
    'DONE' => CustomerBookingStatus.done,
    'NO_SHOW' => CustomerBookingStatus.noShow,
    'REJECTED' => CustomerBookingStatus.rejected,
    'CANCELLED' => CustomerBookingStatus.cancelled,
    _ => CustomerBookingStatus.pending,
  };

  bool get isPast =>
      this == CustomerBookingStatus.done ||
      this == CustomerBookingStatus.noShow ||
      this == CustomerBookingStatus.rejected ||
      this == CustomerBookingStatus.cancelled;

  bool get isCancellable =>
      this == CustomerBookingStatus.pending ||
      this == CustomerBookingStatus.confirmed ||
      this == CustomerBookingStatus.upcoming;
}
