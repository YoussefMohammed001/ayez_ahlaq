abstract class IAutoAttendanceStore {
  bool get isEnabled;

  Future<void> setEnabled(bool value);
}
