import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/models/attendance_history_page_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/models/current_attendance_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';

const _config = {
  'shopLat': 30.3378945,
  'shopLng': 31.7195757,
  'rangeMeters': null,
  'enforced': false,
};

const _openShift = {
  'id': 1,
  'shopId': 3,
  'barberId': 10,
  'barberName': 'كريم',
  'checkInAt': '2026-11-02T23:46:12.852859363',
  'checkOutAt': null,
  'durationMinutes': 0,
  'status': 'OPEN',
  'checkInMethod': 'MANUAL',
  'checkOutMethod': null,
  'checkInLat': 30.3378945,
  'checkInLng': 31.7195757,
  'checkInDistanceMeters': 0,
  'checkOutLat': null,
  'checkOutLng': null,
  'checkOutDistanceMeters': null,
  'adjustedByBarberId': null,
  'adjustNote': null,
};

void main() {
  test('current response while on a shift', () {
    final current = CurrentAttendanceModel.fromJson({
      'onShift': true,
      'shift': _openShift,
      'attendanceConfig': _config,
    });

    expect(current.onShift, true);
    expect(current.shift!.isOpen, true);
    expect(current.shift!.barberName, 'كريم');
    expect(current.shift!.checkInAt.hour, 23);
    expect(current.shift!.checkInAt.minute, 46);
    expect(current.shift!.checkInDistanceMeters, 0);
    expect(current.config.enforced, false);
    expect(current.config.rangeMeters, isNull);
    expect(current.config.shopLat, 30.3378945);
  });

  test('current response when off shift has no shift', () {
    final current = CurrentAttendanceModel.fromJson({
      'onShift': false,
      'shift': null,
      'attendanceConfig': {..._config, 'rangeMeters': 150, 'enforced': true},
    });

    expect(current.onShift, false);
    expect(current.shift, isNull);
    expect(current.config.enforced, true);
    expect(current.config.rangeMeters, 150);
  });

  test('timestamps with and without fractional seconds both parse', () {
    final page = AttendanceHistoryPageModel.fromJson({
      'content': [
        {
          ..._openShift,
          'checkInAt': '2026-11-02T23:46:12',
          'checkOutAt': '2026-11-02T23:46:14.613863347',
          'status': 'CLOSED',
        },
      ],
      'page': 0,
      'size': 20,
      'totalElements': 1,
      'totalPages': 1,
    });

    final shift = page.shifts.single;

    expect(shift.status, AttendanceStatus.closed);
    expect(shift.checkOutAt!.second, 14);
    expect(page.hasMore, false);
  });

  test('history page knows when more pages exist', () {
    final page = AttendanceHistoryPageModel.fromJson({
      'content': [],
      'page': 0,
      'totalPages': 3,
    });

    expect(page.hasMore, true);
  });

  test('adjusted shift keeps its note', () {
    final page = AttendanceHistoryPageModel.fromJson({
      'content': [
        {
          ..._openShift,
          'status': 'ADJUSTED',
          'checkInAt': '2026-11-02T09:00:00',
          'checkOutAt': '2026-11-02T17:00:00',
          'durationMinutes': 480,
          'adjustNote': 'forgot to check out',
        },
      ],
      'page': 0,
      'totalPages': 1,
    });

    expect(page.shifts.single.status, AttendanceStatus.adjusted);
    expect(page.shifts.single.durationMinutes, 480);
    expect(page.shifts.single.adjustNote, 'forgot to check out');
  });
}
