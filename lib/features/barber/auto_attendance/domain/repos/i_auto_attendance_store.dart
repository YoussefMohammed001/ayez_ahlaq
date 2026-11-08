abstract class IAutoAttendanceStore {
  bool get isEnabled;

  DateTime? get trackingHeartbeat;

  Future<void> setEnabled(bool value);

  Future<void> setTrackingHeartbeat(DateTime? at);
}
