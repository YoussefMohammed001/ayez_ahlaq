enum AutoAttendanceOutcome {
  checkedIn,
  checkedOut,
  failed,
  alreadyOnShift,
  noOpenShift,
  featureInactive,
  disabled,
  needsTracking;

  bool get tookEffect =>
      this == AutoAttendanceOutcome.checkedIn ||
      this == AutoAttendanceOutcome.checkedOut;

  bool get isUserFacing => tookEffect || this == AutoAttendanceOutcome.failed;
}
