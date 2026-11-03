import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/team/data/apis/barber_team_api.dart';
import 'package:ayez_ahlaq/features/barber/team/data/repos/barber_team_repo.dart';

class _CapturingApi implements BarberTeamApi {
  Map<String, dynamic>? addBody;
  int? resetId;
  String? sentTempPassword;
  Either<Failure, dynamic> resetResult = const Right({'data': null});

  @override
  Future<Either<Failure, dynamic>> addMember(Map<String, dynamic> body) async {
    addBody = body;
    return const Right({
      'data': {'id': 2000019, 'name': 'x', 'mustChangePassword': true},
    });
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(
    int id,
    String tempPassword,
  ) async {
    resetId = id;
    sentTempPassword = tempPassword;
    return resetResult;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late _CapturingApi api;
  late BarberTeamRepo repo;

  setUp(() {
    api = _CapturingApi();
    repo = BarberTeamRepo(api);
  });

  test('add member without a password does not send the field', () async {
    await repo.addMember(name: 'كريم', phoneNumber: '01111111111');

    expect(api.addBody, {'name': 'كريم', 'phoneNumber': '01111111111'});
    expect(api.addBody!.containsKey('tempPassword'), false);
  });

  test('add member with a password sends tempPassword', () async {
    final result = await repo.addMember(
      name: 'كريم',
      phoneNumber: '01111111111',
      tagline: 'فيد',
      tempPassword: 'Abc12345',
    );

    expect(api.addBody!['tempPassword'], 'Abc12345');
    expect(api.addBody!['tagline'], 'فيد');
    expect(result.isRight(), true);
  });

  test('reset password calls the member and sends tempPassword', () async {
    final result = await repo.resetPassword(2000021, 'Reset123');

    expect(api.resetId, 2000021);
    expect(api.sentTempPassword, 'Reset123');
    expect(result, const Right(unit));
  });

  test('a failed reset returns the failure', () async {
    final failure = Failure('فقط مالك الصالون يمكنه إدارة الفريق', 403, const {});
    api.resetResult = Left(failure);

    final result = await repo.resetPassword(1, 'Reset123');

    expect(result, Left(failure));
  });
}
