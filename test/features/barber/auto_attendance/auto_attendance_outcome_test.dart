import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_outcome.dart';

void main() {
  test('only real actions and failures are shown to people', () {
    final shown = AutoAttendanceOutcome.values.where((o) => o.isUserFacing);

    expect(shown, {
      AutoAttendanceOutcome.checkedIn,
      AutoAttendanceOutcome.checkedOut,
      AutoAttendanceOutcome.failed,
    });
  });

  test('only a check in or out counts as having taken effect', () {
    final effective = AutoAttendanceOutcome.values.where((o) => o.tookEffect);

    expect(effective, {
      AutoAttendanceOutcome.checkedIn,
      AutoAttendanceOutcome.checkedOut,
    });
  });
}
