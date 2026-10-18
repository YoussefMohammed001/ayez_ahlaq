import 'dart:async';

import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/entities/team_member_detail.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/repos/i_barber_team_repo.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/activate_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/block_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/delete_team_member_permanently_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/get_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/set_member_availability_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/update_member_permissions_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/update_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/manager/team_member_detail_cubit.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/manager/team_member_detail_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

TeamMemberDetail member(int id) => TeamMemberDetail(
  id: id,
  name: 'member $id',
  phoneNumber: '0100000000$id',
  tagline: '',
  available: true,
  active: true,
  mustChangePassword: false,
  rating: 0,
  ratingCount: 0,
);

class FakeTeamRepo extends Fake implements IBarberTeamRepo {
  final requestedIds = <int>[];
  final pending = <int, Completer<Either<Failure, TeamMemberDetail>>>{};
  bool failNext = false;

  @override
  Future<Either<Failure, TeamMemberDetail>> getMember(int id) {
    requestedIds.add(id);
    if (failNext) {
      failNext = false;
      return Future.value(Left(Failure('offline', 500, {})));
    }
    final completer = pending[id];
    if (completer != null) return completer.future;
    return Future.value(Right(member(id)));
  }
}

TeamMemberDetailCubit buildCubit(FakeTeamRepo repo) => TeamMemberDetailCubit(
  GetTeamMemberUseCase(repo),
  UpdateTeamMemberUseCase(repo),
  SetMemberAvailabilityUseCase(repo),
  BlockTeamMemberUseCase(repo),
  ActivateTeamMemberUseCase(repo),
  DeleteTeamMemberPermanentlyUseCase(repo),
  UpdateMemberPermissionsUseCase(repo),
);

void main() {
  test('reload retries the member that failed to load', () async {
    final repo = FakeTeamRepo()..failNext = true;
    final cubit = buildCubit(repo);

    await cubit.loadMember(7);
    expect(cubit.state.status, TeamMemberDetailStatus.failure);

    await cubit.reload();

    expect(repo.requestedIds, [7, 7]);
    expect(cubit.state.member?.id, 7);
  });

  test('a slow response for the previous member is ignored', () async {
    final repo = FakeTeamRepo();
    repo.pending[1] = Completer();
    final cubit = buildCubit(repo);

    final first = cubit.loadMember(1);
    await cubit.loadMember(2);
    repo.pending[1]!.complete(Right(member(1)));
    await first;

    expect(cubit.state.member?.id, 2);
  });
}
