import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/apis/barber_attendance_admin_api.dart';
import 'package:ayez_ahlaq/features/barber/attendance/data/repos/barber_attendance_admin_repo.dart';

class _CapturingApi implements BarberAttendanceAdminApi {
  String? checkInAt;
  String? checkOutAt;
  String? note;
  bool? enforced;
  int? rangeMeters;
  bool rangeWasSent = false;

  @override
  Future<Either<Failure, dynamic>> correctRecord({
    required int id,
    required String checkInAt,
    required String checkOutAt,
    required String note,
  }) async {
    this.checkInAt = checkInAt;
    this.checkOutAt = checkOutAt;
    this.note = note;
    return Right({
      'data': {
        'id': id,
        'barberId': 10,
        'barberName': 'x',
        'checkInAt': checkInAt,
        'checkOutAt': checkOutAt,
        'durationMinutes': 480,
        'status': 'ADJUSTED',
        'adjustNote': note,
      },
    });
  }

  @override
  Future<Either<Failure, dynamic>> updateSettings({
    required bool enforced,
    int? rangeMeters,
  }) async {
    this.enforced = enforced;
    this.rangeMeters = rangeMeters;
    return const Right({
      'data': {
        'attendanceConfig': {'rangeMeters': 150, 'enforced': true},
      },
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  test('a correction goes out as local date time without zone or fraction', () async {
    final api = _CapturingApi();
    final repo = BarberAttendanceAdminRepo(api);

    final result = await repo.correctRecord(
      id: 2,
      checkInAt: DateTime(2026, 11, 2, 9, 5, 7, 123),
      checkOutAt: DateTime(2026, 11, 2, 17),
      note: 'forgot to check out',
    );

    expect(api.checkInAt, '2026-11-02T09:05:07');
    expect(api.checkOutAt, '2026-11-02T17:00:00');
    expect(api.note, 'forgot to check out');
    final shift = result.getOrElse(() => throw StateError('failed'));
    expect(shift.durationMinutes, 480);
    expect(shift.adjustNote, 'forgot to check out');
  });

  test('settings are sent with the enforce flag and the range', () async {
    final api = _CapturingApi();
    final repo = BarberAttendanceAdminRepo(api);

    final result = await repo.updateSettings(enforced: true, rangeMeters: 150);

    expect(api.enforced, true);
    expect(api.rangeMeters, 150);
    expect(result.isRight(), true);
  });
}
