import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/models/attendance_setting_log_page_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/models/attendance_settings_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/models/team_attendance_member_model.dart';

void main() {
  test('settings never changed has no author and no range', () {
    final settings = AttendanceSettingsModel.fromJson({
      'attendanceConfig': {
        'shopLat': 30.3378945,
        'shopLng': 31.7195757,
        'rangeMeters': null,
        'enforced': false,
      },
      'updatedByBarberId': null,
      'updatedByName': null,
      'updatedAt': null,
    });

    expect(settings.config.enforced, false);
    expect(settings.config.rangeMeters, isNull);
    expect(settings.updatedByName, isNull);
    expect(settings.updatedAt, isNull);
  });

  test('settings changed by the owner keep the author and time', () {
    final settings = AttendanceSettingsModel.fromJson({
      'attendanceConfig': {
        'shopLat': 30.3378945,
        'shopLng': 31.7195757,
        'rangeMeters': 150,
        'enforced': true,
      },
      'updatedByBarberId': 5,
      'updatedByName': "Men's Club",
      'updatedAt': '2026-11-02T23:48:39.976570977',
    });

    expect(settings.config.enforced, true);
    expect(settings.config.rangeMeters, 150);
    expect(settings.updatedByName, "Men's Club");
    expect(settings.updatedAt!.hour, 23);
    expect(settings.updatedAt!.minute, 48);
  });

  test('team member on and off shift', () {
    final onShift = TeamAttendanceMemberModel.fromJson({
      'barberId': 10,
      'name': 'كريم',
      'owner': false,
      'onShift': true,
      'checkInAt': '2026-11-02T23:48:48',
      'todayMinutes': 12,
    });
    final off = TeamAttendanceMemberModel.fromJson({
      'barberId': 5,
      'name': "Men's Club",
      'owner': true,
      'onShift': false,
      'checkInAt': null,
      'todayMinutes': 0,
    });

    expect(onShift.onShift, true);
    expect(onShift.checkInAt!.minute, 48);
    expect(onShift.todayMinutes, 12);
    expect(off.owner, true);
    expect(off.checkInAt, isNull);
  });

  test('setting log tells what changed', () {
    final page = AttendanceSettingLogPageModel.fromJson({
      'content': [
        {
          'id': 2,
          'actorBarberId': 5,
          'actorName': "Men's Club",
          'oldRangeMeters': null,
          'newRangeMeters': 150,
          'oldEnforced': false,
          'newEnforced': true,
          'createdAt': '2026-11-02T23:48:39',
        },
        {
          'id': 1,
          'actorBarberId': 5,
          'actorName': "Men's Club",
          'oldRangeMeters': 150,
          'newRangeMeters': 150,
          'oldEnforced': true,
          'newEnforced': false,
          'createdAt': '2026-11-02T23:49:03',
        },
      ],
      'page': 0,
      'size': 20,
      'totalElements': 2,
      'totalPages': 1,
    });

    final first = page.entries.first;
    final second = page.entries.last;

    expect(first.rangeChanged, true);
    expect(first.enforcedChanged, true);
    expect(second.rangeChanged, false);
    expect(second.enforcedChanged, true);
    expect(page.hasMore, false);
  });
}
