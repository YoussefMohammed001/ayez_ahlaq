import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/data/apis/merchant_attendance_admin_api.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/data/repos/merchant_attendance_admin_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeApi implements MerchantAttendanceAdminApi {
  Map<String, dynamic>? correction;
  bool? enforcedSent;
  int? rangeSent;
  bool rangeKeySent = false;
  int? historyMember;
  int? historyPage;

  @override
  Future<Either<Failure, dynamic>> getSettings() async => const Right({
    'data': {
      'attendanceConfig': {
        'merchantLat': 37.4219983,
        'merchantLng': -122.084,
        'rangeMeters': 300,
        'enforced': true,
      },
      'updatedAt': '2026-11-11T12:50:10.997910445',
    },
  });

  @override
  Future<Either<Failure, dynamic>> updateSettings({
    required bool enforced,
    int? rangeMeters,
  }) async {
    enforcedSent = enforced;
    rangeSent = rangeMeters;
    return getSettings();
  }

  @override
  Future<Either<Failure, dynamic>> getTeam() async => const Right({
    'data': [
      {
        'merchantMemberId': 4000014,
        'name': 'Sub Test',
        'active': true,
        'checkedIn': false,
        'checkedInSince': null,
        'todayMinutes': 0,
      },
      {
        'merchantMemberId': 4000020,
        'name': 'Second',
        'active': true,
        'checkedIn': true,
        'checkedInSince': '2026-11-11T09:00:00',
        'todayMinutes': 95,
      },
    ],
  });

  @override
  Future<Either<Failure, dynamic>> getSettingLog({
    required int page,
    required int size,
  }) async => const Right({
    'data': {
      'content': [
        {
          'id': 4,
          'oldRangeMeters': 300,
          'newRangeMeters': 300,
          'oldEnforced': true,
          'newEnforced': false,
          'createdAt': '2026-11-11T12:50:10',
        },
        {
          'id': 3,
          'oldRangeMeters': null,
          'newRangeMeters': 300,
          'oldEnforced': false,
          'newEnforced': true,
          'createdAt': '2026-11-11T12:50:08',
        },
      ],
      'page': 0,
      'size': 20,
      'totalElements': 2,
      'totalPages': 1,
    },
  });

  @override
  Future<Either<Failure, dynamic>> getMemberHistory({
    required int memberId,
    required int page,
    required int size,
  }) async {
    historyMember = memberId;
    historyPage = page;
    return const Right({
      'data': {
        'content': [
          {
            'id': 12,
            'memberId': 4000014,
            'memberName': 'Sub Test',
            'checkInAt': '2026-11-11T09:00:00',
            'checkOutAt': '2026-11-11T17:00:00',
            'durationMinutes': 480,
            'status': 'CLOSED',
            'checkInDistanceMeters': 12,
          },
        ],
        'page': 0,
        'size': 20,
        'totalElements': 1,
        'totalPages': 2,
      },
    });
  }

  @override
  Future<Either<Failure, dynamic>> correctRecord({
    required int id,
    required String checkInAt,
    required String checkOutAt,
    required String note,
  }) async {
    correction = {
      'id': id,
      'checkInAt': checkInAt,
      'checkOutAt': checkOutAt,
      'note': note,
    };
    return const Right({
      'data': {
        'id': 12,
        'memberId': 4000014,
        'memberName': 'Sub Test',
        'checkInAt': '2026-11-11T08:30:00',
        'checkOutAt': '2026-11-11T17:00:00',
        'durationMinutes': 510,
        'status': 'ADJUSTED',
        'adjustNote': 'forgot to check in',
      },
    });
  }
}

void main() {
  late _FakeApi api;
  late MerchantAttendanceAdminRepo repo;

  setUp(() {
    api = _FakeApi();
    repo = MerchantAttendanceAdminRepo(api);
  });

  test('the team is mapped from the merchant field names', () async {
    final team = (await repo.getTeam()).getOrElse(
      () => throw StateError('failed'),
    );

    expect(team.map((m) => m.barberId), [4000014, 4000020]);
    expect(team.first.name, 'Sub Test');
    expect(team.first.onShift, isFalse);
    expect(team.first.checkInAt, isNull);
    expect(team.first.owner, isFalse);
    expect(team.last.onShift, isTrue);
    expect(team.last.checkInAt, DateTime(2026, 11, 11, 9));
    expect(team.last.todayMinutes, 95);
  });

  test('settings keep the range and the enforced flag', () async {
    final settings = (await repo.getSettings()).getOrElse(
      () => throw StateError('failed'),
    );

    expect(settings.config.rangeMeters, 300);
    expect(settings.config.enforced, isTrue);
    expect(settings.config.shopLat, 37.4219983);
    expect(settings.updatedByName, isNull);
    expect(settings.updatedAt, isNotNull);
  });

  test('saving settings forwards both values', () async {
    await repo.updateSettings(enforced: true, rangeMeters: 200);

    expect(api.enforcedSent, isTrue);
    expect(api.rangeSent, 200);
  });

  test('the log has no actor name and keeps old and new values', () async {
    final log = (await repo.getSettingLog(
      page: 0,
    )).getOrElse(() => throw StateError('failed'));
    final first = log.entries.first;

    expect(log.entries.length, 2);
    expect(first.actorName, isEmpty);
    expect(first.oldEnforced, isTrue);
    expect(first.newEnforced, isFalse);
    expect(log.entries.last.oldRangeMeters, isNull);
    expect(log.entries.last.newRangeMeters, 300);
  });

  test('a member history reads the member and asks for that member', () async {
    final page = (await repo.getMemberHistory(
      memberId: 4000014,
      page: 0,
    )).getOrElse(() => throw StateError('failed'));

    expect(api.historyMember, 4000014);
    expect(api.historyPage, 0);
    expect(page.shifts.single.barberName, 'Sub Test');
    expect(page.shifts.single.durationMinutes, 480);
    expect(page.shifts.single.status, AttendanceStatus.closed);
    expect(page.hasMore, isTrue);
  });

  test('a correction is sent with seconds and comes back adjusted', () async {
    final shift = (await repo.correctRecord(
      id: 12,
      checkInAt: DateTime(2026, 11, 11, 8, 30),
      checkOutAt: DateTime(2026, 11, 11, 17),
      note: 'forgot to check in',
    )).getOrElse(() => throw StateError('failed'));

    expect(api.correction, {
      'id': 12,
      'checkInAt': '2026-11-11T08:30:00',
      'checkOutAt': '2026-11-11T17:00:00',
      'note': 'forgot to check in',
    });
    expect(shift.status, AttendanceStatus.adjusted);
    expect(shift.adjustNote, 'forgot to check in');
  });
}
