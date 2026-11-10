import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/merchant/team/data/apis/merchant_member_self_api.dart';
import 'package:ayez_ahlaq/features/merchant/team/data/repos/merchant_member_self_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeApi implements MerchantMemberSelfApi {
  String? current;
  String? updated;

  @override
  Future<Either<Failure, dynamic>> getMyHours() async => const Right({
    'data': [
      {
        'dayOfWeek': 0,
        'off': false,
        'opensAt': '09:00:00',
        'closesAt': '17:00:00',
      },
      {'dayOfWeek': 1, 'off': true, 'opensAt': null, 'closesAt': null},
      {
        'dayOfWeek': 6,
        'off': false,
        'opensAt': '22:00:00',
        'closesAt': '02:00:00',
      },
    ],
  });

  @override
  Future<Either<Failure, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    current = currentPassword;
    updated = newPassword;
    return const Right({'data': null, 'message': 'تم تغيير كلمة المرور'});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  test('parses the weekly schedule including an overnight shift', () async {
    final days = (await MerchantMemberSelfRepo(
      _FakeApi(),
    ).getMyHours()).getOrElse(() => throw StateError('failed'));

    expect(days.length, 3);
    expect(days[0].isOpen, isTrue);
    expect(days[0].openMinutes, 9 * 60);
    expect(days[0].closesNextDay, isFalse);
    expect(days[1].isOpen, isFalse);
    expect(days[2].closesNextDay, isTrue);
    expect(days[2].durationMinutes, 4 * 60);
  });

  test('change password sends the current and the new password', () async {
    final api = _FakeApi();

    final result = await MerchantMemberSelfRepo(
      api,
    ).changePassword('123456', 'NewPass123');

    expect(result.isRight(), isTrue);
    expect(api.current, '123456');
    expect(api.updated, 'NewPass123');
  });
}
