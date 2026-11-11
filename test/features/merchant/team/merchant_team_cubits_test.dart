import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member_permissions.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_members_page.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/repos/i_merchant_team_repo.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/activate_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/add_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/block_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/delete_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/get_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/get_merchant_members_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/reset_merchant_member_password_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/set_merchant_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/update_merchant_member_permissions_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/update_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/merchant_member_detail_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/merchant_member_detail_state.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/merchant_team_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/merchant_team_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

MerchantMember member(
  int id, {
  bool active = true,
  double? salary,
  MerchantMemberPermissions permissions = const MerchantMemberPermissions(),
}) => MerchantMember(
  id: id,
  merchantId: 6,
  name: 'member $id',
  phoneNumber: '0100000000$id',
  active: active,
  mustChangePassword: false,
  salary: salary,
  permissions: permissions,
);

class FakeTeamRepo extends Fake implements IMerchantTeamRepo {
  final pagesRequested = <int>[];
  final calls = <String>[];
  Either<Failure, MerchantMember>? nextMemberResult;
  Failure? nextAddFailure;

  @override
  Future<Either<Failure, MerchantMembersPage>> getMembers({
    required int page,
    required int size,
  }) async {
    pagesRequested.add(page);
    return Right(
      MerchantMembersPage(
        members: [member(page * 10 + 1), member(page * 10 + 2)],
        page: page,
        totalPages: 2,
        totalElements: 4,
      ),
    );
  }

  @override
  Future<Either<Failure, MerchantMember>> addMember({
    required String name,
    required String phoneNumber,
    String? password,
    double? salary,
    MerchantMemberPermissions permissions = const MerchantMemberPermissions(),
  }) async {
    calls.add('add:$name:$password:$salary:${permissions.canSell}');
    final failure = nextAddFailure;
    return failure == null ? Right(member(99)) : Left(failure);
  }

  @override
  Future<Either<Failure, MerchantMember>> getMember(int id) async =>
      Right(member(id));

  @override
  Future<Either<Failure, MerchantMember>> setSalary(
    int id,
    double salary,
  ) async {
    calls.add('salary:$id:$salary');
    return nextMemberResult ?? Right(member(id, salary: salary));
  }

  @override
  Future<Either<Failure, MerchantMember>> updatePermissions(
    int id,
    MerchantMemberPermissions permissions,
  ) async {
    calls.add('permissions:$id');
    return Right(member(id, permissions: permissions));
  }

  @override
  Future<Either<Failure, MerchantMember>> blockMember(int id) async {
    calls.add('block:$id');
    return Right(member(id, active: false));
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(int id) async {
    calls.add('reset:$id');
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteMember(int id) async {
    calls.add('delete:$id');
    return Left(Failure('member not found', 404, const {}));
  }
}

MerchantTeamCubit teamCubit(FakeTeamRepo repo) => MerchantTeamCubit(
  GetMerchantMembersUseCase(repo),
  AddMerchantMemberUseCase(repo),
);

MerchantMemberDetailCubit detailCubit(FakeTeamRepo repo) =>
    MerchantMemberDetailCubit(
      GetMerchantMemberUseCase(repo),
      UpdateMerchantMemberUseCase(repo),
      SetMerchantMemberSalaryUseCase(repo),
      UpdateMerchantMemberPermissionsUseCase(repo),
      BlockMerchantMemberUseCase(repo),
      ActivateMerchantMemberUseCase(repo),
      ResetMerchantMemberPasswordUseCase(repo),
      DeleteMerchantMemberUseCase(repo),
    );

void main() {
  group('MerchantTeamCubit', () {
    test('load fills the first page and knows more pages exist', () async {
      final cubit = teamCubit(FakeTeamRepo());

      await cubit.load();

      expect(cubit.state.status, MerchantTeamStatus.success);
      expect(cubit.state.members.map((m) => m.id), [1, 2]);
      expect(cubit.state.hasMore, isTrue);
    });

    test('loadMore appends the next page and stops at the last one', () async {
      final repo = FakeTeamRepo();
      final cubit = teamCubit(repo);
      await cubit.load();

      await cubit.loadMore();
      await cubit.loadMore();

      expect(cubit.state.members.map((m) => m.id), [1, 2, 11, 12]);
      expect(cubit.state.hasMore, isFalse);
      expect(repo.pagesRequested, [0, 1]);
    });

    test(
      'refresh keeps the list on screen instead of showing the loader',
      () async {
        final cubit = teamCubit(FakeTeamRepo());
        await cubit.load();
        final seen = <MerchantTeamStatus>[];
        final subscription = cubit.stream.listen((s) => seen.add(s.status));

        await cubit.refresh();
        await subscription.cancel();

        expect(seen, isNot(contains(MerchantTeamStatus.loading)));
        expect(cubit.state.members, isNotEmpty);
      },
    );

    test('add sends the data, then reloads the list', () async {
      final repo = FakeTeamRepo();
      final cubit = teamCubit(repo);
      await cubit.load();

      final added = await cubit.addMember(
        name: 'Sub',
        phoneNumber: '01099999999',
        salary: 3000,
        permissions: const MerchantMemberPermissions(canSell: true),
      );

      expect(added, isTrue);
      expect(repo.calls, ['add:Sub:null:3000.0:true']);
      expect(repo.pagesRequested, [0, 0]);
      expect(cubit.state.isSubmitting, isFalse);
    });

    test('a failed add keeps the server message and does not reload', () async {
      final repo = FakeTeamRepo()
        ..nextAddFailure = Failure('رقم الهاتف مستخدم بالفعل', 409, const {});
      final cubit = teamCubit(repo);
      await cubit.load();

      final added = await cubit.addMember(name: 'x', phoneNumber: '1');

      expect(added, isFalse);
      expect(cubit.state.errorMessage, 'رقم الهاتف مستخدم بالفعل');
      expect(cubit.state.isSubmitting, isFalse);
      expect(repo.pagesRequested, [0]);
    });
  });

  group('MerchantMemberDetailCubit', () {
    test('actions do nothing before the member is loaded', () async {
      final repo = FakeTeamRepo();
      final cubit = detailCubit(repo);

      expect(await cubit.setSalary(100), isFalse);
      expect(await cubit.blockMember(), isFalse);
      expect(repo.calls, isEmpty);
    });

    test('salary and permissions update the shown member', () async {
      final cubit = detailCubit(FakeTeamRepo());
      await cubit.load(5);

      await cubit.setSalary(4500);
      expect(cubit.state.member?.salary, 4500);

      await cubit.setPermissions(
        const MerchantMemberPermissions(canManageProducts: true),
      );
      expect(cubit.state.member?.canManageProducts, isTrue);
      expect(cubit.state.member?.canSell, isFalse);
    });

    test('block flips the member to inactive', () async {
      final cubit = detailCubit(FakeTeamRepo());
      await cubit.load(5);

      final done = await cubit.blockMember();

      expect(done, isTrue);
      expect(cubit.state.member?.active, isFalse);
    });

    test('reset password succeeds without touching the member', () async {
      final repo = FakeTeamRepo();
      final cubit = detailCubit(repo);
      await cubit.load(5);

      expect(await cubit.resetPassword(), isTrue);
      expect(repo.calls, ['reset:5']);
      expect(cubit.state.errorMessage, isNull);
    });

    test('a failed delete reports the message and returns false', () async {
      final cubit = detailCubit(FakeTeamRepo());
      await cubit.load(5);

      final deleted = await cubit.deleteMember();

      expect(deleted, isFalse);
      expect(cubit.state.errorMessage, 'member not found');
      expect(cubit.state.status, MerchantMemberDetailStatus.success);
    });

    test(
      'a slow load for an old member cannot overwrite a newer one',
      () async {
        final cubit = detailCubit(FakeTeamRepo());

        final first = cubit.load(1);
        await cubit.load(2);
        await first;

        expect(cubit.state.member?.id, 2);
      },
    );
  });
}
