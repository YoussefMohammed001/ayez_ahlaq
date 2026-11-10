import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/merchant/team/data/apis/merchant_team_api.dart';
import 'package:ayez_ahlaq/features/merchant/team/data/repos/merchant_team_repo.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member_permissions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

const _memberJson = {
  'id': 4000014,
  'merchantId': 6,
  'name': 'Sub Test',
  'phoneNumber': '01077777701',
  'active': true,
  'mustChangePassword': true,
  'salary': 4000,
  'canManageProducts': false,
  'canSell': true,
  'createdByMerchantId': 6,
  'createdByAdminId': null,
  'createdAt': '2026-11-10T15:13:11',
};

class _CapturingApi implements MerchantTeamApi {
  Map<String, dynamic>? body;
  int? page;
  int? size;
  double? salary;
  Either<Failure, dynamic> reply = const Right({'data': _memberJson});

  @override
  Future<Either<Failure, dynamic>> getMembers({
    required int page,
    required int size,
  }) async {
    this.page = page;
    this.size = size;
    return const Right({
      'data': {
        'content': [_memberJson],
        'page': 0,
        'size': 20,
        'totalElements': 3,
        'totalPages': 2,
      },
    });
  }

  @override
  Future<Either<Failure, dynamic>> addMember(Map<String, dynamic> body) async {
    this.body = body;
    return reply;
  }

  @override
  Future<Either<Failure, dynamic>> updateMember(
    int id,
    Map<String, dynamic> body,
  ) async {
    this.body = body;
    return reply;
  }

  @override
  Future<Either<Failure, dynamic>> updatePermissions(
    int id,
    Map<String, dynamic> body,
  ) async {
    this.body = body;
    return reply;
  }

  @override
  Future<Either<Failure, dynamic>> setSalary(int id, double salary) async {
    this.salary = salary;
    return reply;
  }

  @override
  Future<Either<Failure, dynamic>> deleteMember(int id) async =>
      const Right({'data': null, 'message': 'member deleted'});

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late _CapturingApi api;
  late MerchantTeamRepo repo;

  setUp(() {
    api = _CapturingApi();
    repo = MerchantTeamRepo(api);
  });

  test('parses a page of members from the real response shape', () async {
    final page = (await repo.getMembers(
      page: 0,
      size: 20,
    )).getOrElse(() => throw StateError('failed'));

    expect(api.page, 0);
    expect(api.size, 20);
    expect(page.members.single.name, 'Sub Test');
    expect(page.members.single.salary, 4000);
    expect(page.members.single.canSell, isTrue);
    expect(page.members.single.canManageProducts, isFalse);
    expect(page.members.single.mustChangePassword, isTrue);
    expect(page.members.single.createdAt, DateTime(2026, 11, 10, 15, 13, 11));
    expect(page.totalElements, 3);
    expect(page.hasMore, isTrue);
  });

  test('add without a password or salary does not send them', () async {
    await repo.addMember(name: 'Sub', phoneNumber: '01099999999');

    expect(api.body, {
      'name': 'Sub',
      'phoneNumber': '01099999999',
      'canManageProducts': false,
      'canSell': false,
    });
  });

  test(
    'add with a password, salary and permissions sends all of them',
    () async {
      await repo.addMember(
        name: 'Sub',
        phoneNumber: '01099999999',
        password: 'abc12345',
        salary: 5000,
        permissions: const MerchantMemberPermissions(canSell: true),
      );

      expect(api.body, {
        'name': 'Sub',
        'phoneNumber': '01099999999',
        'password': 'abc12345',
        'salary': 5000,
        'canManageProducts': false,
        'canSell': true,
      });
    },
  );

  test('update sends only the fields that changed', () async {
    await repo.updateMember(id: 1, name: 'New');

    expect(api.body, {'name': 'New'});
  });

  test('permissions send both flags', () async {
    await repo.updatePermissions(
      1,
      const MerchantMemberPermissions(canManageProducts: true),
    );

    expect(api.body, {'canManageProducts': true, 'canSell': false});
  });

  test('a response without a data object becomes a failure', () async {
    api.reply = const Right({'data': null});

    final result = await repo.setSalary(1, 6000);

    expect(api.salary, 6000);
    expect(result.isLeft(), isTrue);
  });

  test('a server failure is passed through untouched', () async {
    api.reply = Left(Failure('رقم الهاتف مستخدم بالفعل', 409, const {}));

    final result = await repo.addMember(name: 'x', phoneNumber: '1');

    result.fold((failure) {
      expect(failure.statusCode, 409);
      expect(failure.message, 'رقم الهاتف مستخدم بالفعل');
    }, (_) => fail('expected a failure'));
  });

  test('delete maps to unit', () async {
    expect((await repo.deleteMember(1)).isRight(), isTrue);
  });
}
