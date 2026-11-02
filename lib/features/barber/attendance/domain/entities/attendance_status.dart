enum AttendanceStatus {
  open,
  closed,
  adjusted;

  static AttendanceStatus fromApi(String? value) => switch (value) {
    'OPEN' => AttendanceStatus.open,
    'ADJUSTED' => AttendanceStatus.adjusted,
    _ => AttendanceStatus.closed,
  };
}
