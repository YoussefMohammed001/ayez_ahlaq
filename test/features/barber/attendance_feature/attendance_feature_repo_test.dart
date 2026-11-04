import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/apis/attendance_feature_api.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/repos/attendance_feature_repo.dart';

class _FakeApi implements AttendanceFeatureApi {
  Either<Failure, dynamic> statusResult = const Right({'data': {}});
  int? cancelledId;

  @override
  Future<Either<Failure, dynamic>> getStatus() async => statusResult;

  @override
  Future<Either<Failure, dynamic>> requestFeature() async =>
      const Right({'data': {'id': 2}});

  @override
  Future<Either<Failure, dynamic>> cancelRequest(int id) async {
    cancelledId = id;
    return const Right({'data': {'id': 2}});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late _FakeApi api;
  late AttendanceFeatureRepo repo;

  setUp(() {
    api = _FakeApi();
    repo = AttendanceFeatureRepo(api);
  });

  test('a backend without the endpoint counts as the feature being on', () async {
    api.statusResult = Left(Failure('المسار غير موجود', 404, const {}));

    final status = (await repo.getStatus()).getOrElse(
      () => throw StateError('failed'),
    );

    expect(status.enabled, true);
  });

  test('any other failure is passed on', () async {
    final failure = Failure('خطأ', 500, const {});
    api.statusResult = Left(failure);

    expect(await repo.getStatus(), Left(failure));
  });

  test('a real status is parsed', () async {
    api.statusResult = const Right({
      'data': {'enabled': false, 'state': 'NONE', 'owner': true},
    });

    final status = (await repo.getStatus()).getOrElse(
      () => throw StateError('failed'),
    );

    expect(status.enabled, false);
    expect(status.owner, true);
  });

  test('request and cancel return unit and pass the id', () async {
    expect(await repo.requestFeature(), const Right(unit));
    expect(await repo.cancelRequest(2), const Right(unit));
    expect(api.cancelledId, 2);
  });
}
