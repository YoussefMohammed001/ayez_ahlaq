import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/profile/domain/entities/barber_permissions.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/entities/team_member.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/entities/team_member_detail.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/repos/i_barber_team_repo.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/activate_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/add_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/block_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/delete_team_member_permanently_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/get_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/get_team_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/reset_member_password_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/set_member_availability_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/update_member_permissions_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/update_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/manager/barber_team_cubit.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/manager/team_member_detail_cubit.dart';

const _member = TeamMemberDetail(
  id: 7,
  name: 'x',
  phoneNumber: '01111111111',
  tagline: '',
  available: true,
  active: true,
  mustChangePassword: true,
  rating: 0,
  ratingCount: 0,
);

class _FakeRepo implements IBarberTeamRepo {
  String? addedPassword;
  int addCalls = 0;
  int? resetId;
  String? sentTempPassword;
  Either<Failure, Unit> resetResult = const Right(unit);

  @override
  Future<Either<Failure, TeamMemberDetail>> addMember({
    required String name,
    required String phoneNumber,
    String? tagline,
    String? tempPassword,
  }) async {
    addCalls++;
    addedPassword = tempPassword;
    return const Right(_member);
  }

  @override
  Future<Either<Failure, List<TeamMember>>> getTeam() async =>
      const Right(<TeamMember>[]);

  @override
  Future<Either<Failure, TeamMemberDetail>> getMember(int id) async =>
      const Right(_member);

  @override
  Future<Either<Failure, Unit>> resetPassword(
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
  late _FakeRepo repo;

  setUp(() => repo = _FakeRepo());

  TeamMemberDetailCubit detailCubit() => TeamMemberDetailCubit(
    GetTeamMemberUseCase(repo),
    UpdateTeamMemberUseCase(repo),
    SetMemberAvailabilityUseCase(repo),
    BlockTeamMemberUseCase(repo),
    ActivateTeamMemberUseCase(repo),
    DeleteTeamMemberPermanentlyUseCase(repo),
    UpdateMemberPermissionsUseCase(repo),
    ResetMemberPasswordUseCase(repo),
  );

  test('reset password sends the loaded member id and the password', () async {
    final cubit = detailCubit();
    await cubit.loadMember(7);

    final done = await cubit.resetPassword('Reset123');

    expect(done, true);
    expect(repo.resetId, 7);
    expect(repo.sentTempPassword, 'Reset123');
    expect(cubit.state.isSubmitting, false);
    expect(cubit.state.errorMessage, isNull);
  });

  test('reset password without a loaded member does nothing', () async {
    final cubit = detailCubit();

    final done = await cubit.resetPassword('Reset123');

    expect(done, false);
    expect(repo.resetId, isNull);
  });

  test('a rejected reset keeps the message and stops the busy state', () async {
    repo.resetResult = Left(Failure('فقط مالك الصالون يمكنه إدارة الفريق', 403, const {}));
    final cubit = detailCubit();
    await cubit.loadMember(7);

    final done = await cubit.resetPassword('Reset123');

    expect(done, false);
    expect(cubit.state.errorMessage, 'فقط مالك الصالون يمكنه إدارة الفريق');
    expect(cubit.state.isSubmitting, false);
    expect(cubit.state.member, _member);
  });

  BarberTeamCubit teamCubit() => BarberTeamCubit(
    GetTeamUseCase(repo),
    AddTeamMemberUseCase(repo),
    UpdateMemberPermissionsUseCase(repo),
  );

  test('adding a member passes the password through', () async {
    final result = await teamCubit().addMember(
      name: 'كريم',
      phoneNumber: '01111111111',
      tempPassword: 'Abc12345',
      permissions: BarberPermissions.none,
    );

    expect(result.member, _member);
    expect(repo.addedPassword, 'Abc12345');
  });

  test('adding a member without a password passes null', () async {
    await teamCubit().addMember(name: 'كريم', phoneNumber: '01111111111');

    expect(repo.addCalls, 1);
    expect(repo.addedPassword, isNull);
  });
}
