enum BookingStatus {
  pending,
  confirmed,
  upcoming,
  next,
  active,
  done,
  noShow,
  rejected,
  cancelled;

  static BookingStatus fromApi(String? value) => switch (value) {
    'PENDING' => BookingStatus.pending,
    'CONFIRMED' => BookingStatus.confirmed,
    'UPCOMING' => BookingStatus.upcoming,
    'NEXT' => BookingStatus.next,
    'ACTIVE' => BookingStatus.active,
    'DONE' => BookingStatus.done,
    'NO_SHOW' => BookingStatus.noShow,
    'REJECTED' => BookingStatus.rejected,
    'CANCELLED' => BookingStatus.cancelled,
    _ => BookingStatus.pending,
  };

  String toApi() => switch (this) {
    BookingStatus.pending => 'PENDING',
    BookingStatus.confirmed => 'CONFIRMED',
    BookingStatus.upcoming => 'UPCOMING',
    BookingStatus.next => 'NEXT',
    BookingStatus.active => 'ACTIVE',
    BookingStatus.done => 'DONE',
    BookingStatus.noShow => 'NO_SHOW',
    BookingStatus.rejected => 'REJECTED',
    BookingStatus.cancelled => 'CANCELLED',
  };

  bool get isTerminal =>
      this == BookingStatus.done ||
      this == BookingStatus.noShow ||
      this == BookingStatus.rejected ||
      this == BookingStatus.cancelled;

  bool get needsDecision => this == BookingStatus.pending;
}
